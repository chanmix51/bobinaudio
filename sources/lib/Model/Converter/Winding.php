<?php
namespace Model\Converter;

use Pomm\Converter\ConverterInterface;

class Winding implements ConverterInterface
{
    public function fromPg($data, $type = null)
    {
        if (!preg_match('/^([^,]+),(.*)$/', trim($data, '()'), $matchs))
        {
            throw new \InvalidArgumentException(sprintf("Invalid Winding representation '%s'.", $data));
        }

        return new \Model\Type\Winding($matchs[1], $matchs[2]);
    }

    public function toPg($data, $type = null)
    {
        if (!$data instanceOf \Model\Type\Winding)
        {
            throw new \InvalidArgumentException(sprintf("Invalid type passed for Winding '%s'.", gettype($data)));
        }

        return sprintf("transfo.winding '(%05.1f,%05.3f)'", $data->voltage, $data->current);
    }
}
