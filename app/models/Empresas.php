<?php

use Phalcon\Mvc\Model;

/**
 * Modelo de Empresa del cliente
 * Universidad Distrital Francisco Jose de Caldas - LDWS
 */
class Empresas extends Model
{
    /**
     * @var integer
     */
    public $IdEmpresa;

    /**
     * @var string
     */
    public $Nombre;

    /**
     * @var string
     */
    public $Nit;

    /**
     * @var string
     */
    public $Mision;

    /**
     * @var string
     */
    public $Vision;

    /**
     * @var integer
     */
    public $IdUsuario;

    /**
     * @var string
     */
    public $created_at;

    public function initialize()
    {
        $this->setSource('empresas');
        $this->belongsTo('IdUsuario', 'Users', 'id', ['alias' => 'usuario']);
        $this->hasMany('IdEmpresa', 'Solicitudes', 'IdEmpresa', ['alias' => 'solicitudes']);
        $this->hasMany('IdEmpresa', 'Pisos', 'id_empresa', ['alias' => 'pisos']);
    }
}
