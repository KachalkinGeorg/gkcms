<?php

namespace GKcms\File;

class ImageHelper {
    public static function resize($sourceImage, $targetImage, $maxWidth, $maxHeight, $mimeType, $quality = 80)
    {
        // Obtain image from given source file.
        $imgString = file_get_contents($sourceImage);
        //if (!$image = @imagecreatefromjpeg($sourceImage))
        if (!$image = @imagecreatefromstring($imgString))
        {
            return false;
        }

        // Get dimensions of source image.
        list($origWidth, $origHeight) = getimagesize($sourceImage);

        if ($maxWidth == 0)
        {
            $maxWidth  = $origWidth;
        }

        if ($maxHeight == 0)
        {
            $maxHeight = $origHeight;
        }

        $quality = ($quality < 0) ? 0 : $quality;
        $quality = ($quality > 100) ? 100 : $quality;

        // Calculate ratio of desired maximum sizes and original sizes.
        $widthRatio = $maxWidth / $origWidth;
        $heightRatio = $maxHeight / $origHeight;

        // Ratio used for calculating new image dimensions.
        $ratio = min($widthRatio, $heightRatio);

        // Calculate new image dimensions.
        $newWidth  = (int)$origWidth  * $ratio;
        $newHeight = (int)$origHeight * $ratio;

        // Create final image with new dimensions.
        $newImage = imagecreatetruecolor($newWidth, $newHeight);
        imagealphablending($newImage, false);
        imagesavealpha($newImage, true);
        imagecopyresampled($newImage, $image, 0, 0, 0, 0, $newWidth, $newHeight, $origWidth, $origHeight);

        $res = false;
        switch ($mimeType) {
            case "jpeg":
            case "jpg":
                $res = imagejpeg($newImage, $targetImage, $quality);
                break;
            case "png":
                if($quality >= 1 && $quality <= 10) $quality = 9;
                elseif($quality >= 90) $quality = 1;
                else $quality = 10 - (floor($quality / 10));

                $res = imagepng($newImage, $targetImage, $quality);
                break;
            case "gif":
                $res = imagegif($newImage, $targetImage);
                break;
            case "webp":
                if (imagetypes() & IMG_WEBP) {
                    $res = imagewebp($newImage, $targetImage, $quality);
                } else {
                    imagedestroy($image);
                    imagedestroy($newImage);
                    throw new \Exception("Формат WEBP не поддерживается");
                }
                break;
            default:
                imagedestroy($image);
                imagedestroy($newImage);
                throw new \Exception("Неизвестный тип изображения - " . $mimeType);
                break;
        }

        // Free up the memory.
        imagedestroy($image);
        imagedestroy($newImage);

        return $res;
    }

    public static function makeThumb($image, $width = 0, $height = 0, $destination = null, $format=null)
    {
        //todo format list
        if(!is_file($image)) return '';
        if(!$width && !$height) return '';

        if($destination === null) $destination = $image;
        $dir = pathinfo($destination)['dirname'];
        if(!is_dir($dir)) {
            @mkdir($dir, 0777, true);
        }

        $thumb = new \PHPThumb\GD($image);
        if($width && $height) $thumb->adaptiveResize($width, $height);
        else $thumb->resize($width, $height);
        $thumb->save($destination, $format);
    }
}