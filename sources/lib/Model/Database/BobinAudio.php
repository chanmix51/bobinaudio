<?php
namespace Model\Database;

class BobinAudio extends \Pomm\Connection\Database
{
    protected function registerBaseConverters()
    {
        parent::registerBaseConverters();

        $this->registerConverter('Winding', new \Model\Converter\Winding(), array('transfo.winding'));
    }
}
