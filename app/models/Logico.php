<?php

use Phalcon\Mvc\Model;

class Logico extends Model
{
    /**
     * @var integer
     */
    public $id_solicitud;

    /**
     * @var string
     */
    public $redundancia;

    /**
     * @var string
     */
    public $escalabilidad;

    /**
     * @var string
     */
    public $subredes;

    /**
     * @var string
     */
    public $desc_subred;

     /**
     * @var string
     */
    public $scripts;

    /**
     * @var string
     */
    public $tabla_dirip;
}
