<?php

namespace GKcms\File;

class FileHelper {

    public static function formatSize($file_size) {
        if ($file_size >= 1073741824) {
            $file_size = round($file_size / 1073741824 * 100) / 100 . " GB";
        } elseif ($file_size >= 1048576) {
            $file_size = round($file_size / 1048576 * 100) / 100 . " MB";
        } elseif ($file_size >= 1024) {
            $file_size = round($file_size / 1024 * 100) / 100 . " KB";
        } else {
            $file_size = $file_size . " B";
        }

        return $file_size;
    }
}