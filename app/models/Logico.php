<?php

use Phalcon\Mvc\Model;

/**
 * Modelo de Diseno Logico de Red
 * Universidad Distrital Francisco Jose de Caldas - LDWS
 */
class Logico extends Model
{
    /**
     * @var integer
     */
    public $id_logico;

    /**
     * @var integer
     */
    public $id_solicitud;

    /**
     * @var boolean
     */
    public $redundancia;

    /**
     * @var string
     */
    public $escalabilidad;

    /**
     * @var integer
     */
    public $subredes;

    /**
     * @var string
     */
    public $desc_subred;

    /**
     * @var boolean
     */
    public $scripts;

    /**
     * @var boolean
     */
    public $tabla_dirip;

    /**
     * @var string
     */
    public $created_at;

    public function initialize()
    {
        $this->setSource('logico');
        $this->belongsTo('id_solicitud', 'Solicitudes', 'IdSolicitud', ['alias' => 'solicitud']);
    }

    /**
     * Genera la estructura formal de direccionamiento IP y VLANs
     */
    public function getVlansCalculadas()
    {
        return [
            [
                'vlan_id' => 10,
                'nombre' => 'DATOS_USUARIOS',
                'red' => '192.168.10.0/24',
                'mascara' => '255.255.255.0',
                'gateway' => '192.168.10.1',
                'rango_dhcp' => '192.168.10.10 - 192.168.10.240',
                'proposito' => 'Puestos de trabajo y estaciones fijas por piso'
            ],
            [
                'vlan_id' => 20,
                'nombre' => 'VOZ_SOBRE_IP',
                'red' => '192.168.20.0/24',
                'mascara' => '255.255.255.0',
                'gateway' => '192.168.20.1',
                'rango_dhcp' => '192.168.20.10 - 192.168.20.240',
                'proposito' => 'Telefonos IP corporativos con prioridad QoS DSCP EF'
            ],
            [
                'vlan_id' => 30,
                'nombre' => 'SERVIDORES',
                'red' => '192.168.30.0/24',
                'mascara' => '255.255.255.0',
                'gateway' => '192.168.30.1',
                'rango_dhcp' => 'IPs Estaticas (192.168.30.10 - 192.168.30.50)',
                'proposito' => 'Granja de servidores locales (Web, BD, DNS, DHCP, Active Directory)'
            ],
            [
                'vlan_id' => 50,
                'nombre' => 'GESTION_RED',
                'red' => '192.168.50.0/24',
                'mascara' => '255.255.255.0',
                'gateway' => '192.168.50.1',
                'rango_dhcp' => 'IPs Estaticas (Switches, Routers, APs)',
                'proposito' => 'Administracion remota SSH y SNMP de dispositivos de red'
            ],
            [
                'vlan_id' => 99,
                'nombre' => 'WIFI_INVITADOS',
                'red' => '192.168.99.0/24',
                'mascara' => '255.255.255.0',
                'gateway' => '192.168.99.1',
                'rango_dhcp' => '192.168.99.10 - 192.168.99.250',
                'proposito' => 'Red inalambrica aislada de invitados con salida restringida'
            ]
        ];
    }

    /**
     * Genera el script de configuracion Cisco IOS para Switches de Acceso
     */
    public function getCiscoSwitchConfig()
    {
        return "! ========================================================\n" .
               "! UNIVERSIDAD DISTRITAL FRANCISCO JOSE DE CALDAS - LDWS\n" .
               "! Script de Configuracion: Cisco Catalyst Switch de Acceso\n" .
               "! ========================================================\n" .
               "enable\n" .
               "configure terminal\n" .
               "hostname SW-ACCESO-LDWS\n" .
               "\n" .
               "! 1. Creacion de VLANs segun diseno logico\n" .
               "vlan 10\n name DATOS_USUARIOS\n" .
               "vlan 20\n name VOZ_SOBRE_IP\n" .
               "vlan 30\n name SERVIDORES\n" .
               "vlan 50\n name GESTION_RED\n" .
               "vlan 99\n name WIFI_INVITADOS\n" .
               "exit\n" .
               "\n" .
               "! 2. Configuracion de Enlace Troncal (Uplink al Switch de Distribucion)\n" .
               "interface GigabitEthernet0/24\n" .
               " description UPLINK_HACIA_DISTRIBUCION\n" .
               " switchport trunk encapsulation dot1q\n" .
               " switchport mode trunk\n" .
               " switchport trunk allowed vlan 10,20,30,50,99\n" .
               " exit\n" .
               "\n" .
               "! 3. Configuracion de Puertos de Acceso (Datos + Telefonia IP)\n" .
               "interface range GigabitEthernet0/1 - 20\n" .
               " description PUESTOS_DE_TRABAJO_CON_TELEFONO_VOIP\n" .
               " switchport mode access\n" .
               " switchport access vlan 10\n" .
               " switchport voice vlan 20\n" .
               " spanning-tree portfast\n" .
               " spanning-tree bpduguard enable\n" .
               " exit\n" .
               "\n" .
               "! 4. Interfaz de Administracion (SVI)\n" .
               "interface vlan 50\n" .
               " description SVI_GESTION_SWITCH\n" .
               " ip address 192.168.50.11 255.255.255.0\n" .
               " no shutdown\n" .
               " exit\n" .
               "ip default-gateway 192.168.50.1\n" .
               "end\n" .
               "write memory\n";
    }

    /**
     * Genera el script de configuracion Cisco IOS para Router / Gateway de Borde
     */
    public function getCiscoRouterConfig()
    {
        $redundanciaCfg = "";
        if ($this->redundancia) {
            $redundanciaCfg = "! Redundancia de Primer Salto (HSRP)\n" .
                              " standby 10 ip 192.168.10.254\n" .
                              " standby 10 priority 110\n" .
                              " standby 10 preempt\n";
        }

        return "! ========================================================\n" .
               "! UNIVERSIDAD DISTRITAL FRANCISCO JOSE DE CALDAS - LDWS\n" .
               "! Script de Configuracion: Router de Borde / Inter-VLAN\n" .
               "! ========================================================\n" .
               "enable\n" .
               "configure terminal\n" .
               "hostname R1-BORDE-LDWS\n" .
               "\n" .
               "! 1. Interfaz Fisica conectada al Switch de Distribucion\n" .
               "interface GigabitEthernet0/0/0\n" .
               " no shutdown\n" .
               " exit\n" .
               "\n" .
               "! 2. Subinterfaces Inter-VLAN (Router-on-a-Stick)\n" .
               "interface GigabitEthernet0/0/0.10\n" .
               " description GATEWAY_VLAN_10_DATOS\n" .
               " encapsulation dot1Q 10\n" .
               " ip address 192.168.10.1 255.255.255.0\n" .
               $redundanciaCfg .
               " exit\n" .
               "\n" .
               "interface GigabitEthernet0/0/0.20\n" .
               " description GATEWAY_VLAN_20_VOIP\n" .
               " encapsulation dot1Q 20\n" .
               " ip address 192.168.20.1 255.255.255.0\n" .
               " exit\n" .
               "\n" .
               "interface GigabitEthernet0/0/0.30\n" .
               " description GATEWAY_VLAN_30_SERVIDORES\n" .
               " encapsulation dot1Q 30\n" .
               " ip address 192.168.30.1 255.255.255.0\n" .
               " exit\n" .
               "\n" .
               "! 3. Servidor DHCP Integrado\n" .
               "ip dhcp excluded-address 192.168.10.1 192.168.10.9\n" .
               "ip dhcp pool POOL_DATOS\n" .
               " network 192.168.10.0 255.255.255.0\n" .
               " default-router 192.168.10.1\n" .
               " dns-server 192.168.30.10 8.8.8.8\n" .
               " lease 7 0 0\n" .
               " exit\n" .
               "end\n" .
               "write memory\n";
    }
}
