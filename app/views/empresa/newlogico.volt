<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous">{{ link_to("empresa/newpiso", "Volver a Pisos") }}</li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h2>Diseño Lógico de Red <small>Paso 4: Segmentación VLAN, Redundancia y Enrutamiento</small></h2>
</div>

{{ content() }}

<div class="panel panel-default">
    <div class="panel-body">
        <p class="lead">
            Defina los parámetros lógicos de alta disponibilidad, segmentación de tráfico y escalabilidad de red.
        </p>

        {{ form("empresa/newlogico", "method":"post", "class":"form-horizontal") }}
            <div class="form-group">
                <label class="col-sm-3 control-label">Alta Disponibilidad y Redundancia</label>
                <div class="col-sm-9">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="redundancia" checked> <strong>Habilitar Protocolos de Redundancia (HSRP / Rapid-PVST+)</strong>
                        </label>
                    </div>
                    <p class="help-block">Proporciona tolerancia a fallos en gateways de primer salto y prevención de bucles en enlaces troncales.</p>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">Escalabilidad Proyectada</label>
                <div class="col-sm-9">
                    <input class="form-control" type="text" placeholder="Ej: 35% de margen de crecimiento en puertos y direccionamiento" name="escalabilidad" value="35% de holgura" required>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">Número de Subredes / VLANs</label>
                <div class="col-sm-9">
                    <input type="number" placeholder="Ej: 4" class="form-control" name="subredes" value="4" required>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">Descripción de Subredes</label>
                <div class="col-sm-9">
                    <textarea class="form-control" rows="3" placeholder="Ej: VLAN 10 Datos, VLAN 20 VoIP, VLAN 30 Servidores, VLAN 99 Invitados" name="desc" required>VLAN 10: Datos Usuarios, VLAN 20: Telefonia IP con QoS, VLAN 30: Servidores Corporativos, VLAN 99: Red Wi-Fi Invitados</textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">Automatización Cisco IOS</label>
                <div class="col-sm-9">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="script" checked> <strong>Generar Scripts de Aprovisionamiento para Switches y Routers</strong>
                        </label>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">Esquema VLSM</label>
                <div class="col-sm-9">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="ip" checked> <strong>Generar Tabla de Direccionamiento IP y Rangos DHCP</strong>
                        </label>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-3 col-sm-9">
                    {{ submit_button("Guardar Diseño y Ver Topología &raquo;", "class": "btn btn-success") }}
                    {{ link_to("grafica", "Ir directamente a Gráfica", "class": "btn btn-default") }}
                </div>
            </div>
        {{ end_form() }}
    </div>
</div>
