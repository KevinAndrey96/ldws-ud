<?php

use Phalcon\Mvc\Model;

class Solicitudes extends Model
{
    /**
     * @var integer
     */
    public $IdEmpresa;

    /**
     * @var string
     */
    public $Descripcion;

    /**
     * @var string
     */
    public $Objetivos;

    /**
     * @var string
     */
    public $Observaciones;

    /**
     * @var string
     */
    public $Servicio;
}
