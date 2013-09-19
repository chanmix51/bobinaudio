<?php
namespace Model\Type;

class Winding
{
    public $current;
    public $voltage;

    public function __construct($voltage, $current)
    {
        $this->voltage = $voltage;
        $this->current = $current;
    }

    public function getPowerMax()
    {
        return $this->voltage * $this->current;
    }
}
