<?php

use Phalcon\Mvc\Model;

/**
 * Modelo de Solicitud de Diseno de Red
 * Universidad Distrital Francisco Jose de Caldas - LDWS
 */
class Solicitudes extends Model
{
    /**
     * @var integer
     */
    public $IdSolicitud;

    /**
     * @var integer
     */
    public $IdEmpresa;

    /**
     * @var string
     */
    public $titulo;

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

    /**
     * @var string
     */
    public $created_at;

    public function initialize()
    {
        $this->setSource('solicitudes');
        $this->belongsTo('IdEmpresa', 'Empresas', 'IdEmpresa', ['alias' => 'empresa']);
        $this->hasOne('IdSolicitud', 'Logico', 'id_solicitud', ['alias' => 'logico']);
        $this->hasMany('IdSolicitud', 'Equipos', 'id_solicitud', ['alias' => 'equipos']);
    }
}
