<?php  

header('content-type: image/jpeg');  

$dato = $argv[1];

$watermark = imagecreatefrompng('logo_moledo.png');  
$watermark_width = imagesx($watermark);  
$watermark_height = imagesy($watermark);  
$image = imagecreatetruecolor($watermark_width, $watermark_height);  

$image = imagecreatefromjpeg($dato);  
if (!$image) {
	sleep(1);
	$image = imagecreatefromjpeg($dato);
}
$size = getimagesize($dato);  
$dest_x = $size[0] - $watermark_width - 5;
$dest_y = $size[1] - $watermark_height - 5;
imagecopymerge($image, $watermark, $dest_x, $dest_y, 0, 0, $watermark_width, $watermark_height, 100);

// Create some colors

$waira = imagecolorallocate($image, 252, 182, 4);
$white = imagecolorallocate($image, 255, 255, 255);
$grey = imagecolorallocate($image, 128, 128, 128);
$black = imagecolorallocate($image, 0, 0, 0);
$blue = imagecolorallocate($image, 3, 7, 70);
#imagefilledrectangle($image, 0, 0, 399, 29, $white);

// The text to draw
$text = substr($dato, 32, 2).'/'.substr($dato, 30, 2).'/'.substr($dato, 26, 4).' '.substr($dato, 35, 2).':'.substr($dato, 37, 2).':'.substr($dato, 39, 2);

// Replace path by your own font path
$font = './arial.ttf';

// Add some shadow to the text
#imagettftext($image, 20, 0, 11, 21, $grey, $font, $text);

// Add the text
imagettftext($image, 20, 0, 10, $size[1]-10, $blue, $font, $text);

imagejpeg($image);
imagedestroy($image);
imagedestroy($watermark);

?>
