<?php

use Phalcon\Mvc\Model;

class Pisos extends Model
{
    /**
     * @var integer
     */
    public $id_empresa;

    /**
     * @var integer
     */
    public $alto;

    /**
     * @var integer
     */
    public $ancho;

    /**
     * @var integer
     */
    public $largo;

    /**
     * @var integer
     */
    public $equipos;

    /**
     * @var boolean
     */
    public $sala;
}
