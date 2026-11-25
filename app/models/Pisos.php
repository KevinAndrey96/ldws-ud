<?php

use Phalcon\Mvc\Model;

/**
 * Modelo de Piso del edificio y caracteristicas fisicas
 * Universidad Distrital Francisco Jose de Caldas - LDWS
 */
class Pisos extends Model
{
    /**
     * @var integer
     */
    public $id_piso;

    /**
     * @var integer
     */
    public $id_empresa;

    /**
     * @var integer
     */
    public $numero;

    /**
     * @var double
     */
    public $alto;

    /**
     * @var double
     */
    public $ancho;

    /**
     * @var double
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

    /**
     * @var string
     */
    public $created_at;

    public function initialize()
    {
        $this->setSource('pisos');
        $this->belongsTo('id_empresa', 'Empresas', 'IdEmpresa', ['alias' => 'empresa']);
    }

    /**
     * Calcula el area total del piso en metros cuadrados
     */
    public function getArea()
    {
        return round((float)$this->largo * (float)$this->ancho, 2);
    }

    /**
     * Estima la longitud total de cableado horizontal UTP Cat 6 (metros)
     * segun distancia media al rack MDF/IDF con factor de holgura del 15%
     */
    public function getCableMetros()
    {
        $distanciaMedia = (1.2 * (((float)$this->largo + (float)$this->ancho) / 2)) + (float)$this->alto;
        $totalMetros = (int)$this->equipos * $distanciaMedia * 1.15;
        return round($totalMetros, 1);
    }

    /**
     * Calcula el numero de bobinas/cajas de cable UTP (305 metros por caja)
     */
    public function getCajasUtp()
    {
        return (int) ceil($this->getCableMetros() / 305.0);
    }

    /**
     * Calcula la cantidad de Puntos de Acceso Wi-Fi (WAP) requeridos
     */
    public function getAccessPoints()
    {
        $porArea = ceil($this->getArea() / 200.0);
        $porDispositivos = ceil((int)$this->equipos / 30.0);
        return (int) max(1, max($porArea, $porDispositivos));
    }

    /**
     * Calcula los switches de acceso (24 puertos) necesarios considerando holgura
     */
    public function getSwitchesAcceso()
    {
        $puertosNecesarios = (int)$this->equipos + $this->getAccessPoints();
        $puertosConHolgura = ceil($puertosNecesarios * 1.20);
        return (int) max(1, ceil($puertosConHolgura / 24.0));
    }
}
