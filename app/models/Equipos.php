<?php

use Phalcon\Mvc\Model;

/**
 * Modelo de Equipos de Red calculados para el diseno LAN
 * Universidad Distrital Francisco Jose de Caldas - LDWS
 */
class Equipos extends Model
{
    /**
     * @var integer
     */
    public $id_equipo;

    /**
     * @var integer
     */
    public $id_solicitud;

    /**
     * @var string
     */
    public $tipo_equipo;

    /**
     * @var string
     */
    public $modelo;

    /**
     * @var integer
     */
    public $capa_osi;

    /**
     * @var integer
     */
    public $cantidad;

    /**
     * @var integer
     */
    public $puertos;

    /**
     * @var string
     */
    public $ubicacion;

    /**
     * @var string
     */
    public $descripcion;

    /**
     * @var string
     */
    public $created_at;

    public function initialize()
    {
        $this->setSource('equipos');
        $this->belongsTo('id_solicitud', 'Solicitudes', 'IdSolicitud', [
            'alias' => 'solicitud'
        ]);
    }
}
