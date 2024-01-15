<?php
/**
 * BULLETPROOF.
 */
namespace Bulletproof;

class Files implements \ArrayAccess
{
    /**
     * @var string The new name, to be provided or will be generated
     */
    protected $name;

    /**
     * @var string The mime type (extension)
     */
    protected $mime;

    /**
     * @var string The full path (dir + mime)
     */
    protected $fullPath;

    /**
     * @var string The folder or storage location
     */
    protected $location;

    /**
     * @var array The min and max size allowed for upload (in bytes)
     */
    protected $size = array(100, 500000);

    /**
     * @var array The mime types allowed for upload
     */
   // protected $mimeTypes = array('torrent', 'zip', 'rar', 'gz', 'tgz', 'bz2'); //перенесена в FileUploader для $config['files_ext']

    protected $debugMode = false;

    /**
     * @var string The language
     */
    protected $language = 'english';

    /**
     * @var array error messages strings
     */
    protected $commonUploadErrors = array(
        'english' => array(
            UPLOAD_ERR_OK => '',
            UPLOAD_ERR_INI_SIZE => 'File is larger than the specified amount set by the server',
            UPLOAD_ERR_FORM_SIZE => 'File is larger than the specified amount specified by browser',
            UPLOAD_ERR_PARTIAL => 'File could not be fully uploaded. Please try again later',
            UPLOAD_ERR_NO_FILE => 'File is not found',
            UPLOAD_ERR_NO_TMP_DIR => 'Can\'t write to disk, due to server configuration ( No tmp dir found )',
            UPLOAD_ERR_CANT_WRITE => 'Failed to write file to disk. Please check you file permissions',
            UPLOAD_ERR_EXTENSION => 'A PHP extension has halted this file upload process',

            'ERROR_01' => 'No file input found with name: (%1$s)',
            'ERROR_02' => 'Can not create a directory%1$s, please check write permission',
            'ERROR_03' => 'Error! directory %1$scould not be created',
            'ERROR_04' => 'Invalid File! Only (%1$s) file types are allowed',
            'ERROR_05' => 'File size should be minumum %1$s, upto maximum %2$s',
            'ERROR_06' => 'File height/width should be less than %1$s/%2$s pixels',
            'ERROR_07' => 'Error! the language does not exist',
        ),
        'russian' => array(
            UPLOAD_ERR_OK => '',
            UPLOAD_ERR_INI_SIZE => 'Размер файла превышает установленные сервером лимиты',
            UPLOAD_ERR_FORM_SIZE => 'Размер файла превышает установленные браузером лимиты',
            UPLOAD_ERR_PARTIAL => 'Невозможно загрузить изображение. Пожалуйста, попробуйте позже',
            UPLOAD_ERR_NO_FILE => 'Файл не существует',
            UPLOAD_ERR_NO_TMP_DIR => 'Не получается записать данные на диск (Не найдена временная папка)',
            UPLOAD_ERR_CANT_WRITE => 'Не удалось записать файл на диск. Пожалуйста, проверьте ваши права доступа к файлам',
            UPLOAD_ERR_EXTENSION => 'Расширение PHP остановило процесс загрузки файлов',

            'ERROR_01' => 'Не найден файл с именем: (%1$s)',

            'ERROR_02' => 'Невозможно создать папку %1$s.<br>Проверьте права доступа',
            'ERROR_03' => 'Не получается создать папку %1$s<br>для загрузки файла',
            'ERROR_04' => 'Выбран некорректный файл!<br>К загрузке разрешены файлы следующего типа:<br>%1$s',
            'ERROR_05' => 'Размер файла должен быть в диапозоне от %1$s до %2$s',
            'ERROR_06' => 'Ширина/высота файла не должна превышать %2$s/%1$s пикселей',
            'ERROR_07' => 'Ошибка с локализацией',
        ),
    );

    /**
     * @var array storage for the global array
     */
    private $_files = array();

    /**
     * @var string storage for any errors
     */
    private $error = '';

    /**
     * @param array $_files represents the $_FILES array passed as dependency
     */
    public function __construct(array $_files = array())
    {
        $this->_files = $_files;
    }

    /**
     * \ArrayAccess unused method
     *
     * @param mixed $offset
     * @param mixed $value
     */
    public function offsetSet($offset, $value) {}

    /**
     * \ArrayAccess unused method
     *
     * @param mixed $offset
     */
    public function offsetExists($offset){}

    /**
     * \ArrayAccess unused method
     *
     * @param mixed $offset
     */
    public function offsetUnset($offset){}

    /**
     * \ArrayAccess - get array value from object
     *
     * @param mixed $offset
     *
     * @return string|bool
     */
    public function offsetGet($offset)
    {
        // return false if $_FILES['key'] isn't found
        if (!isset($this->_files[$offset])) {
            $this->error = sprintf($this->commonUploadErrors[$this->language]['ERROR_01'], $offset);
            return false;
        }

        $this->_files = $this->_files[$offset];

        // check for common upload errors
        if (isset($this->_files['error'])) {
            $this->error = $this->commonUploadErrors[$this->language][$this->_files['error']];
        }

        return true;
    }


    /**
     * Returns the full path of the ex 'location/image.mime'.
     *
     * @return string
     */
    public function getFullPath()
    {
        return $this->fullPath = $this->getLocation().'/'.$this->getName().'.'.$this->getMime();
    }

    /**
     * Define a language
     *
     * @param $lang string language code
     *
     * @return $this
     */
    public function setLanguage($lang)
    {
        if (isset($this->commonUploadErrors[$lang])) {
            $this->language = $lang;
        } else {
            $this->error = $this->commonUploadErrors[$this->language]['ERROR_07'];
        }

        return $this;
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

    /**
     * Define a min and max size for uploading.
     *
     * @param $min int minimum value in bytes
     * @param $max int maximum value in bytes
     *
     * @return $this
     */
    public function setSize($min, $max)
    {
        $this->size = array($min, $max);
        return $this;
    }

    /**
     * Returns a JSON format of the width, height, name, mime ...
     *
     * @return string
     */
    public function getJson()
    {
        return json_encode(
            array(
                'name' => $this->name,
                'mime' => $this->mime,
                'size' => $this->_files['size'],
                'location' => $this->location,
                'fullpath' => $this->fullPath,
            )
        );
    }

    /**
     * Returns the mime type.
     *
     * @return null|string
     */
    public function getMime()
    {
        if (!$this->mime) {
            $this->mime = $this->getImageMime($this->_files['tmp_name']);
        }

        return $this->mime;
    }

    /**
     * Define a mime type for uploading.
     *
     * @param array $fileTypes
     *
     * @return $this
     */
    public function setMime(array $fileTypes)
    {
        $this->mimeTypes = $fileTypes;
        return $this;
    }

    /**
     * Gets the real mime type.
     *
     * @param $tmp_name string The upload tmp directory
     *
     * @return null|string
     */
    protected function getImageMime($tmp_name)
    {

		$this->mime = $tmp_name;

        if (!$this->mime) {
            return null;
        }

        return $this->mime;
    }

    /**
     * Returns error string
     *
     * @return string
     */
    public function getError()
    {
        return $this->error;
    }

    /**
     * Returns the name.
     *
     * @return string
     */
    public function getName()
    {
        if (!$this->name) {
            $this->name = uniqid('', true).'_'.str_shuffle(implode(range('e', 'q')));
        }

        return $this->name;
    }

    /**
     * Provide name if not provided.
     *
     * @param null $isNameProvided
     *
     * @return $this
     */
    public function setName($isNameProvided = null)
    {
        if ($isNameProvided) {
            $this->name = filter_var($isNameProvided, FILTER_SANITIZE_STRING);
        }

        return $this;
    }


    /**
     * Returns the storage / folder name.
     *
     * @return string
     */
    public function getLocation()
    {
        if (!$this->location) {
            $this->setLocation();
        }

        return $this->location;
    }

    /**
     * Validate directory/permission before creating a folder.
     *
     * @param $dir string the folder name to check
     *
     * @return bool
     */
    private function isDirectoryValid($dir)
    {
        return !file_exists($dir) && !is_dir($dir) || is_writable($dir);
    }

    /**
     * Creates a location for upload storage.
     *
     * @param $dir string the folder name to create
     * @param int $permission chmod permission
     *
     * @return $this
     */
    public function setLocation($dir = 'bulletproof', $permission = 0666)
    {
        $isDirectoryValid = $this->isDirectoryValid($dir);

        if (!$isDirectoryValid) {
            $this->error = sprintf($this->commonUploadErrors[$this->language]['ERROR_02'], $this->getDebugMode() ? " ({$dir})" : '');
            return false;
        }

        $create = !is_dir($dir) ? @mkdir('' . $dir, (int) $permission, true) : true;

        if (!$create) {
            $this->error = sprintf($this->commonUploadErrors[$this->language]['ERROR_03'], $this->getDebugMode() ? "({$dir}) " : '');
            return false;
        }

        $this->location = $dir;

        return $this;
    }

    /**
     * Validate size, dimension or mimetypes
     *
     * @return boolean
     */
    protected function contraintsValidator($type)
    {
        /* check for valid mime types and return mime */
        $this->getImageMime($type);
        /* validate mime type */
        if (!in_array($this->mime, $this->mimeTypes)) {
            $this->error = sprintf($this->commonUploadErrors[$this->language]['ERROR_04'], implode(', ', $this->mimeTypes));
            return false;
        }

        /* get sizes */
        list($minSize, $maxSize) = $this->size;

        /* check size based on the settings */
        if ($this->_files['size'] < $minSize || $this->_files['size'] > $maxSize) {
            //$min = $minSize.' bytes ('.intval($minSize / 1000).' kb)';
            //$max = $maxSize.' bytes ('.intval($maxSize / 1000).' kb)';
            $min = intval($minSize / 1000).' KB';
            $max = intval($maxSize / 1000).' KB';
            $this->error = sprintf($this->commonUploadErrors[$this->language]['ERROR_05'], $min, $max);
            return false;
        }

        return true;
    }

    /**
     * Validate and save (upload) file
     *
     * @return false|Image
     */
    public function upload($type)
    {
        if ($this->error !== '') {
            return false;
        }

        $isValid = $this->contraintsValidator($type);

        $isSuccess = $isValid && $this->isSaved($this->_files['tmp_name'], $this->getFullPath());

        return $isSuccess ? $this : false;
    }

    /**
     * Final upload method to be called, isolated for testing purposes.
     *
     * @param $tmp_name int the temporary location of the file
     * @param $destination int upload destination
     *
     * @return bool
     */
    protected function isSaved($tmp_name, $destination)
    {
        return move_uploaded_file($tmp_name, $destination);
    }
}