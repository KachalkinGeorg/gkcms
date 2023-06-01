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

        if( empty($config['images_dir']) || empty($imageInfo['filepath']) || empty($imageInfo['filename']) ) {
            return false;
        }

        $imagePath = $config['images_dir'] . '/' . $imageInfo['filepath'] . '/';
        if(file_exists($imagePath . $imageInfo['filename'])){
            if( unlink($imagePath . $imageInfo['filename']) === false ) {
                return false;
            }
        }

        if( !empty($imageInfo['thumb']) ){
            $thumbPath = $imagePath . 'thumb/' . $imageInfo['filename'];
            if(file_exists($thumbPath)){
                unlink($thumbPath);
            }
        }

        return true;
    }
}