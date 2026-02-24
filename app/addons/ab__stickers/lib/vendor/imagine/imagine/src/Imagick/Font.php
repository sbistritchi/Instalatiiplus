<?php

/*
 * This file is part of the Imagine package.
 *
 * (c) Bulat Shakirzyanov <mallluhuct@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace Imagine\Imagick;

use Imagine\Driver\InfoProvider;
use Imagine\Image\AbstractFont;
use Imagine\Image\Palette\Color\ColorInterface;

/**
 * Font implementation using the Imagick PHP extension.
 */
final class Font extends AbstractFont implements InfoProvider
{
    /**
     * @var \Imagick
     */
    private $imagick;

    /**
     * @param \Imagick $imagick
     * @param string $file
     * @param int $size
     * @param \Imagine\Image\Palette\Color\ColorInterface $color
     */
    public function __construct(\Imagick $imagick, $file, $size, ColorInterface $color)
    {
        $this->imagick = $imagick;

        parent::__construct($file, $size, $color);
    }

    /**
     * {@inheritdoc}
     *
     * @see \Imagine\Driver\InfoProvider::getDriverInfo()
     * @since 1.3.0
     */
    public static function getDriverInfo($required = true)
    {
        return DriverInfo::get($required);
    }

    /**
     * {@inheritdoc}
     *
     * @see \Imagine\Image\FontInterface::box()
     */
    public function box($string, $angle = 0, $params = array())
    {
        $text = new \ImagickDraw();

        $text->setFont($this->file);

        // ensure font resolution is the same as GD's hard-coded 96
        if (static::getDriverInfo()->hasFeature(DriverInfo::FEATURE_CUSTOMRESOLUTION)) {
            $text->setResolution(96, 96);
            $text->setFontSize($this->size);
        } else {
            $text->setFontSize((int) ($this->size * (96 / 72)));
        }

        // AB: take into account the size of the text stroke width
        if (isset($params['stroke_width'])) {
            $text->setStrokeWidth((float)$params['stroke_width']);
            $text->setStrokeAntialias(true);
        }

        $info = $this->imagick->queryFontMetrics($text, $string);

        /*
        * This "blunt fix" avoids cropping the lower part of the image
        */
        $h = $info['textHeight'] + 1 + ($params['stroke_width'] ?? 0);
        $w = $info['textWidth'] + 1 + ($params['stroke_width'] ?? 0);

        $box = $this->getClassFactory()->createBox($w, $h);

        return $box;
    }
}
