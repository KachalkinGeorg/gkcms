<?php

namespace GKcms\File;

class FileManager {

    public function __construct(){
        //
    }

    public function fileDelete($file){
        return unlink($file);
    }

    public function imageNewsDelete(array $imageInfo) {
        global $config;

        if( empty($config['images_dir']) || empty($imageInfo['folder']) || empty($imageInfo['name']) ) {
            return false;
        }

        $imagePath = $config['images_dir'] . '/' . $imageInfo['folder'] . '/';
        if(file_exists($imagePath . $imageInfo['name'])){
            if( unlink($imagePath . $imageInfo['name']) === false ) {
                return false;
            }
        }

        if( $config['thumb_mode'] == 2 || ($config['thumb_mode'] == 0 ) ){
            $thumbPath = $imagePath . 'thumb/' . $imageInfo['name'];
            if(file_exists($thumbPath)){
                unlink($thumbPath);
            }
        }

        return true;
    }
	
    public function fileNewsDelete(array $fileInfo) {
        global $config;

        if( empty($config['files_dir']) || empty($fileInfo['folder']) || empty($fileInfo['name']) ) {
            return false;
        }

        $filePath = $config['files_dir'] . '/' . $fileInfo['folder'] . '/';
        if(file_exists($filePath . $fileInfo['name'])){
            if( unlink($filePath . $fileInfo['name']) === false ) {
                return false;
            }
        }

        return true;
    }
}