<?php
use Phalcon\Mvc\Model;
class Rol extends Model
{
	/**
	 * @var integer
	 */
	public $id;

	/**
	 * @var string
	 */
	public $nombre;

	/**
	 * @var string
	 */
	public $descripcion;

	/**
	 * @var string
	 */
	public $created_at;

	/**
	 * @var string
	 */
	public $update_at;
}

