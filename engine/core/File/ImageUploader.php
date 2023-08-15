<?php

namespace GKcms\File;

class ImageUploader {
    protected $extensions;
    protected $debugMode = false;

    protected $destination;
    protected $imagePath;
    protected $minFilesize = 1;
    protected $maxFilesize;
    protected $filenameMode;
    protected $filenameRandomOptions = [10]; //length
    protected $filenameStrictMode;
    protected $filename;
    protected $originalFilename;
    protected $originalFilesize;
    protected $originalWidth;
    protected $originalHeight;
    protected $maxWidth;
    protected $maxHeight;

    protected $resizeIfBigger;
    protected $resizeQuality;

    protected $isCreateThumb;
    protected $thumbDir = null;
    protected $thumbPath = null;
    protected $thumbWidth;
    protected $thumbQuality;

    protected $imageFilesize;
    protected $imageWidth;
    protected $imageHeight;

    public function __construct(){
        global $config;

        $imageExts = array_map('trim', explode(',', $config['images_ext']));
        $this->extensions = $imageExts;

        if($config['images_dir']){
            /* $this->imagePath = date("Y/m/d");  */
			$this->imagePath = date("Y-d"); 
            $this->destination = $config['images_dir'] . $this->imagePath;
        }

        $this->maxFilesize = (int)$config['images_max_size'] * 1024;
        $this->filenameMode = 'random';
        $this->maxWidth = $config['images_max_x'];
        $this->maxHeight = $config['images_max_y'];

        $this->resizeIfBigger = $config['images_dim_action'];
        $this->resizeQuality = $config['images_size_quality'];

        $this->isCreateThumb = 1;
        $this->thumbWidth = $config['thumb_size_y'];
        $this->thumbQuality = $config['thumb_quality'];
    }

    //$rootImageDir - general path to images directory; example: /var/www/public_html/images/
    //$imagePath - internal path to images directory; example: year/2000
    public function setDestination($rootImageDir, $imagePath = null){
        $this->destination = $rootImageDir;
        if($imagePath){
            $this->imagePath = $imagePath;
            $this->destination .= $imagePath;
        }
        $this->thumbDir = $rootImageDir;
    }

    public function setMaxDimensions($maxWidth = null, $maxHeight = null){
        if ($maxWidth !== null) $this->maxWidth = (int)$maxWidth;
        if ($maxHeight !== null) $this->maxHeight = (int)$maxHeight;
    }

    //in KB
    public function setFilesize($maxFilesizeKB, $minFilesizeKB = 1){
        $this->minFilesize = (int)$minFilesizeKB * 1024;
        $this->maxFilesize = (int)$maxFilesizeKB * 1024;
    }

    public function resizeIfBigger($isResize, $resizeQuality = null){
        $this->resizeIfBigger = (bool)$isResize;
        if ($resizeQuality !== null) $this->resizeQuality = $resizeQuality;
    }

    protected function _resizeImage($sourceImagePath, $resizedImagePath, $maxWidth, $maxHeight, $mimeType, $imageQuality = 80){
        return ImageHelper::resize(
            $sourceImagePath,
            $resizedImagePath,
            $maxWidth,
            $maxHeight,
            $mimeType,
            $imageQuality
        );
    }

    public function setThumbMode($isCreate, $thumbWidth = 0, $thumbDir = null, $thumbPath = null, $thumbQuality = null){
        $this->isCreateThumb = (bool)$isCreate;
        if ($thumbWidth > 0) $this->thumbWidth = $thumbWidth;
        if ($thumbDir !== null) $this->thumbDir = $thumbDir;
        if ($thumbPath !== null) $this->thumbPath = $thumbDir;
        if ($thumbQuality !== null) $this->thumbQuality = $thumbQuality;
    }

    public function filenameRandom($length = 10){
        $this->filenameMode = 'random';

        $length = (int)$length;
        if($length < 1) $length = 10;
        if($length > 32) $length = 32;
        $this->filenameRandomOptions = [$length];
    }

    public function filenameCustom($filename, $isStrictMode = false){
        $this->filename = $filename;
        $this->filenameMode = 'custom';
        $this->filenameStrictMode = (bool)$isStrictMode;
    }

    public function filenameOriginal($isStrictMode = false){
        $this->filenameMode = 'original';
        $this->filenameStrictMode = (bool)$isStrictMode;
    }

    public function setExtensions(array $extensions){
        $this->extensions = $extensions;
    }

    public function setDebugMode($mode = false)
    {
        $this->debugMode = (bool)$mode;
        return $this;
    }

    public function getDebugMode()
    {
        return $this->debugMode;
    }

    public function upload($files, $fileInputName, $formatResults = 'array'){
        $image = new \Bulletproof\Image($files);
        if( !$image[$fileInputName] ){
            throw new \Exception('Не выбрано изображение для загрузки');
        }

        $image->setLanguage('ru');
        $image->setDebugMode($this->getDebugMode());
        $image->setLocation($this->destination, 0775);
        if($image->getError()){
            throw new \Exception($image->getError());
        }

        $image->setMime($this->extensions);
        $this->originalFilename = pathinfo( $files[$fileInputName]['name'] )['filename'];
        $image->setName( $this->generateFilename($this->originalFilename, $image->getMime()) );
        $image->setSize($this->minFilesize, $this->maxFilesize);

        if($this->resizeIfBigger) $image->setDimension(0, 0); //disable check
        else $image->setDimension($this->maxWidth, $this->maxHeight);

        $isScaling = false;
        if( ( !empty($this->maxWidth) && $image->getWidth() > $this->maxWidth ) || ( !empty($this->maxHeight) && $image->getHeight() > $this->maxHeight ) ){
            if( $this->resizeIfBigger ){
                //todo output if zero
                $isScaling = true;
            } else {
                throw new \Exception("Размеры загружаемого изображения превышают допустимые значения ({$this->maxWidth}x{$this->maxHeight})");
            }
        }

        $upload = $image->upload();
        if($upload === false){
            throw new \Exception($image->getError());
        }

        $this->imageFilesize = $this->originalFilesize = filesize($image->getFullPath());
        list($this->imageWidth, $this->imageHeight) = getimagesize($image->getFullPath());
        $this->originalWidth = $this->imageWidth;
        $this->originalHeight = $this->imageHeight;

        if( $isScaling ){
            $this->scalingBigger($image->getWidth(), $image->getHeight(), $image->getMime(), $image->getFullPath());
        }

        $thumbInfo = [];
        $thumbError = null;
        try {
            if($this->isCreateThumb && $image->getWidth() > $this->thumbWidth){
                $thumbInfo = $this->createThumb($image->getName(), $image->getMime(), $image->getFullPath());
            }
        } catch (\Exception $e) {
            $thumbError = $e->getMessage();
        }

        $uploadInfo = $this->uploadInfo($image, $isScaling, $thumbInfo, $thumbError);
        return ($formatResults == 'json') ? json_encode($uploadInfo) : $uploadInfo;
    }

    protected function uploadInfo(\Bulletproof\Image $image, $isScaling, $thumbInfo, $thumbError){
        $info = [
            'filename' => $image->getName(),
            'mime' => $image->getMime(),
            'width' => $this->imageWidth,
            'height' => $this->imageHeight,
            'size' => $this->imageFilesize,
            'location' => $image->getLocation(),
            'fullpath' => $image->getFullPath(),
            'path' => $this->imagePath,
            'original_filename' => filter_var($this->originalFilename, FILTER_SANITIZE_STRING),
        ];

        if($isScaling){
            $info['is_scaling'] = 1;
            $info['original_width'] = $this->originalWidth;
            $info['original_height'] = $this->originalHeight;
            $info['original_size'] = $this->originalFilesize;
        }

        if(!empty($thumbInfo) || $thumbError !== null){
            if($thumbError) $info['thumb']['error'] = $thumbError;
            else {
                $info['thumb'] = [
                    'width' => $thumbInfo['width'],
                    'height' => $thumbInfo['height'],
                    'size' => $thumbInfo['size'],
                    'fullpath' => $thumbInfo['fullpath'],
                    'path' => $thumbInfo['path'],
                ];
            }
        }

        return $info;
    }

    public function uploadSystemMode($files, $fileInputName, $linkedEntityId, $linkedModule, $uploaderId = null, $datetimeUpload = null , $insertOriginalFilename = false){
        global $mysql, $userROW;

        $uploadInfo = $this->upload($files, $fileInputName, 'array');

        $SQL = [
            'name' => $uploadInfo['filename'] . '.' . $uploadInfo['mime'],
			'description' => '',
			'user' => $userROW['name'],
            'folder' => $uploadInfo['path'],
            'linked_ds' => $linkedModule,
            'linked_id' => (int)$linkedEntityId,
            'width' => (int)$uploadInfo['width'],
            'height' => (int)$uploadInfo['height'],
            'filesize' => (int)$uploadInfo['size'],
			'stamp' => 0,
			'category' => 0,
			'plugin' => 'gk',
			'pidentity' => '',
            'preview' => ( isset($uploadInfo['thumb']['width']) ) ? 1 : 0,
            'p_width' => ( isset($uploadInfo['thumb']['width']) ) ? $uploadInfo['thumb']['width'] : NULL,
            'p_height' => ( isset($uploadInfo['thumb']['height']) ) ? $uploadInfo['thumb']['height'] : NULL,
            'date' => ($datetimeUpload === null) ? time() : $datetimeUpload,
            'owner_id' => ($uploaderId === null) ? $userROW['id'] : (int)$uploaderId,
        ];
        if($insertOriginalFilename){
            $SQL['orig_name'] = $uploadInfo['original_filename'];
        }
        $vk = [];
        $vv = [];
        foreach ($SQL as $k => $v) {
            $vk[] = $k;
            $vv[] = db_squote($v);
        }

        try {
            $mysql->query("INSERT INTO " . prefix . "_images (" . implode(",", $vk) . ") VALUES (" . implode(",", $vv) . ")");
            $uploadInfo['image_id'] = $mysql->result("SELECT LAST_INSERT_ID() AS id");

            //todo trans
            //module - 1 (GKcms news)
            if($linkedModule == '1'){
                if( (int)$linkedEntityId > 0 ){
                    $mysql->query("UPDATE " . prefix . "_news SET num_images=num_images+1 WHERE id=".(int)$linkedEntityId);
                }
            }
        } catch (\Exception $e) {
            unlink($uploadInfo['fullpath']);
            if( isset($uploadInfo['thumb']['width']) ){
                unlink($uploadInfo['thumb']['fullpath']);
            }

            throw new \Exception('Ошибка загрузки изображения (при записи в БД)');
        }

        return $uploadInfo;
    }

    public function uploadNewsMode($files, $fileInputName, $newsId, $formatResults = 'array'){
        $uploadInfo = $this->uploadSystemMode($files, $fileInputName, $newsId, '1');
        return ($formatResults == 'json') ? json_encode($uploadInfo) : $uploadInfo;
    }

    protected function generateFilename($originalName, $imageMime){
        if(!$this->destination){
            throw new \Exception('Не указана папка для загрузки изображения');
        }
        $existFilename = false;
        $attempt = 0;
        while(true){
            if($this->filenameMode == 'random'){
                list($filenameRandomLength) = $this->filenameRandomOptions;
                $fileName = mb_substr($this->_generateRandomFilename(), 0, $filenameRandomLength);
            } else {
                if($this->filenameMode == 'custom'){
                    $fileName = $this->filename;
                } else {
                    //original
                    $fileName = $originalName;
                }

                if($existFilename) {
                    if($this->filenameStrictMode){
                        throw new \Exception('Файл с таким названием уже существует!');
                    }
                    $fileName .= '-'.rand(1, 1000);
                }
            }

            if(!file_exists($this->destination . '/' . $fileName . '.' . $imageMime)){
                return $fileName;
            }
            $existFilename = true;

            $attempt++;
            if($attempt == 100){
                throw new \Exception('Проблема с выбором названия для изображения');
            }
        }
    }

    protected function _generateRandomFilename(){
        return md5(uniqid('', true));
    }

    protected function scalingBigger($imageWidth, $imageHeight, $imageMime, $imageFullPath){
        if($this->maxWidth > 0 && $imageWidth > $this->maxWidth){
            $newWidth = $this->maxWidth;
            $newHeight = 0;
        }
        elseif ($this->maxHeight > 0 && $imageHeight > $this->maxHeight) {
            $newHeight = $this->maxHeight;
            $newWidth = 0;
        }

        $isResized = $this->_resizeImage($imageFullPath, $imageFullPath, $newWidth, $newHeight, $imageMime, $this->resizeQuality);

        if($isResized) {
            clearstatcache();
            $this->imageFilesize = filesize($imageFullPath);
            list($this->imageWidth, $this->imageHeight) = getimagesize($imageFullPath);
        } else {
            unlink($imageFullPath);
            throw new \Exception('Возникли проблемы при масштабировании большого изображения');
        }
    }

    protected function createThumb($imageName, $imageMime, $imageFullPath){
        $this->thumbDir = ($this->thumbDir !== null) ? $this->thumbDir : $this->destination;
        $this->thumbPath = ($this->thumbPath !== null) ? $this->thumbPath : (($this->imagePath) ? $this->imagePath . '/' : '') . 'thumb';
        $thumbDestination = $this->thumbDir . '/' . $this->thumbPath;
        if(!is_dir($thumbDestination)){
            if (!mkdir($thumbDestination, 0777, true)) {
                throw new \Exception('Не получается создать директорию (' . $thumbDestination . ') для миниатюры. Проверьте права доступа.');
            }
        }

        $thumbFile = $thumbDestination . '/' . $imageName . '.' . $imageMime;

        $thumbCreated = $this->_resizeImage($imageFullPath, $thumbFile, $this->thumbWidth, 0, $imageMime, $this->thumbQuality);

        if( !$thumbCreated || !$thumbInfo['size'] = filesize($thumbFile) ){
            throw new \Exception('Ошибка при создании миниатюры');
        }

        $thumbInfo['filename'] = $imageName;
        $thumbInfo['mime'] = $imageMime;
        $thumbInfo['fullpath'] = $thumbFile;
        $thumbInfo['path'] = $this->thumbPath;
        list($thumbInfo['width'], $thumbInfo['height']) = getimagesize($thumbFile);

        return $thumbInfo;
    }
}