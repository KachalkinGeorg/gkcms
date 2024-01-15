<?php

namespace GKcms\File;

class FileUploader {
    protected $extensions;
    protected $debugMode = false;

    protected $destination;
    protected $filePath;
    protected $minFilesize = 1;
    protected $maxFilesize;
    protected $filenameMode;
    protected $filenameRandomOptions = [10]; //length
    protected $filenameStrictMode;
    protected $filename;
    protected $originalFilename;
    protected $originalFilesize;

    protected $resizeQuality;

    protected $imageFilesize;

    public function __construct(){
        global $config;

        $imageExts = array_map('trim', explode(',', $config['files_ext']));
        $this->extensions = $imageExts;

        if($config['files_dir']){
			$this->filePath = date("Y-d"); 
            $this->destination = $config['files_dir'] . $this->filePath;
        }

        $this->maxFilesize = (int)$config['files_max_size'] * 1024;
        $this->filenameMode = 'original';

        $this->resizeQuality = $config['images_size_quality'];

    }

    //$rootImageDir - general path to images directory; example: /var/www/public_html/images/
    //$filePath - internal path to images directory; example: year/2000
    public function setDestination($rootImageDir, $filePath = null){
        $this->destination = $rootImageDir;
        if($filePath){
            $this->filePath = $filePath;
            $this->destination .= $filePath;
        }
    }

    //in KB
    public function setFilesize($maxFilesizeKB, $minFilesizeKB = 1){
        $this->minFilesize = (int)$minFilesizeKB * 1024;
        $this->maxFilesize = (int)$maxFilesizeKB * 1024;
    }

    public function filenameRandom($filename, $length = 10){
        $this->filenameMode = $filename;

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
		global $config;
		
        $image = new \Bulletproof\Files($files);
        if( !$image[$fileInputName] ){
            throw new \Exception('Не выбрано изображение для загрузки');
        }
		
		$path_info = pathinfo($files[$fileInputName]['name']);
		$type = $path_info['extension'];

        $image->setLanguage($config['default_lang']);
        $image->setDebugMode($this->getDebugMode());
        $image->setLocation($this->destination, 0775);
        if($image->getError()){
            throw new \Exception($image->getError());
        }

        $image->setMime($this->extensions);
        $this->originalFilename = pathinfo( $files[$fileInputName]['name'] )['filename'];
        $image->setName( $this->generateFilename($this->originalFilename, $image->getMime()) );
        $image->setSize($this->minFilesize, $this->maxFilesize);
		
		$mimeTypes = $this->extensions;

        $upload = $image->upload($type);
        if($upload === false){
            throw new \Exception($image->getError());
        }

        $this->imageFilesize = $this->originalFilesize = filesize($image->getFullPath());

        $uploadInfo = $this->uploadInfo($image, $type);
        return ($formatResults == 'json') ? json_encode($uploadInfo) : $uploadInfo;
    }

    protected function uploadInfo(\Bulletproof\Files $image, $type){
        $info = [
            'filename' => $image->getName(),
            'mime' => $image->getMime(),
            'size' => $this->imageFilesize,
            'location' => $image->getLocation(),
            'fullpath' => $image->getFullPath(),
            'path' => $this->filePath,
            'original_filename' => filter_var($this->originalFilename, FILTER_SANITIZE_STRING),
        ];
        return $info;
    }

    public function uploadSystemMode($files, $fileInputName, $linkedEntityId, $linkedModule, $uploaderId = null, $datetimeUpload = null , $insertOriginalFilename = false){
        global $mysql, $userROW;

        $uploadInfo = $this->upload($files, $fileInputName, 'array');

        $SQL = [
            'name' => $uploadInfo['filename'] . '.' . $uploadInfo['mime'],
			'orig_name' => $uploadInfo['filename'],
			'description' => '',
			'user' => $userROW['name'],
            'folder' => $uploadInfo['path'],
            'linked_ds' => $linkedModule,
            'linked_id' => (int)$linkedEntityId,
			'filesize' => (int)$uploadInfo['size'],
			'category' => 0,
			'plugin' => 'gk',
			'pidentity' => '',
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
            $mysql->query("INSERT INTO " . prefix . "_files (" . implode(",", $vk) . ") VALUES (" . implode(",", $vv) . ")");
            $uploadInfo['file_id'] = $mysql->result("SELECT LAST_INSERT_ID() AS id");

            //todo trans
            //module - 1 (GKcms news)
            if($linkedModule == '1'){
                if( (int)$linkedEntityId > 0 ){
                    $mysql->query("UPDATE " . prefix . "_news SET num_files=num_files+1 WHERE id=".(int)$linkedEntityId);
                }
            }
        } catch (\Exception $e) {
            unlink($uploadInfo['fullpath']);

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


}