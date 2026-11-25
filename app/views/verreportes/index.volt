<div class="row hidden-print">
    <div class="col-md-6">
        <h2>Reporte Técnico Top-Down <small>Diseño de Redes LAN</small></h2>
    </div>
    <div class="col-md-6 text-right" style="margin-top: 20px;">
        <button class="btn btn-primary" onclick="window.print();"><i class="glyphicon glyphicon-print"></i> Imprimir / Exportar PDF</button>
        {{ link_to("gestionequipos", "Volver a Equipos", "class": "btn btn-default") }}
    </div>
</div>

<hr class="hidden-print">

<!-- Encabezado Institucional del Reporte -->
<div class="panel panel-primary">
    <div class="panel-heading text-center">
        <h4><strong>UNIVERSIDAD DISTRITAL FRANCISCO JOSE DE CALDAS</strong></h4>
        <h5>Facultad de Ingenieria - Proyecto de Grado LDWS</h5>
        <p>Modelo para el Diseno de Redes en Entornos LAN basado en un Sistema Multinivel (Metodologia Top-Down)</p>
    </div>
    <div class="panel-body">
        <div class="row">
            <div class="col-md-6">
                <p><strong>Empresa Cliente:</strong> {{ empresa.Nombre }}</p>
                <p><strong>NIT:</strong> {{ empresa.Nit }}</p>
                <p><strong>Proyecto / Solicitud:</strong> {{ solicitud ? solicitud.titulo : 'Diseno Red LAN Corporativa' }}</p>
            </div>
            <div class="col-md-6">
                <p><strong>Area Total:</strong> {{ totalArea }} m²</p>
                <p><strong>Total Puestos Terminales:</strong> {{ totalPuestos }} hosts</p>
                <p><strong>Servicios Requeridos:</strong> {{ solicitud ? solicitud.Servicio : 'Web, BD, VoIP, DNS, DHCP' }}</p>
            </div>
        </div>
    </div>
</div>

<!-- Seccion 1: Objetivos y Mision -->
<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title"><strong>1. Analisis de Requerimientos de Negocio</strong></h4>
    </div>
    <div class="panel-body">
        <p><strong>Mision:</strong> {{ empresa.Mision }}</p>
        <p><strong>Vision:</strong> {{ empresa.Vision }}</p>
        {% if solicitud %}
            <p><strong>Descripcion del Proyecto:</strong> {{ solicitud.Descripcion }}</p>
            <p><strong>Objetivos de Conectividad:</strong> {{ solicitud.Objetivos }}</p>
            <p><strong>Observaciones Tecnicas:</strong> {{ solicitud.Observaciones }}</p>
        {% endif %}
    </div>
</div>

<!-- Seccion 2: Diseno Fisico por Niveles -->
<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title"><strong>2. Diseno Fisico y Cableado Estructurado (Norma TIA/EIA-568-C)</strong></h4>
    </div>
    <div class="panel-body">
        <table class="table table-bordered table-striped">
            <thead>
                <tr class="info">
                    <th>Nivel</th>
                    <th>Dimensiones (L x A x H)</th>
                    <th>Area (m²)</th>
                    <th>Puestos (Equipos)</th>
                    <th>Cuarto Telecomunicaciones</th>
                    <th>Cable UTP Cat 6</th>
                    <th>Bobinas (305m)</th>
                    <th>Access Points</th>
                </tr>
            </thead>
            <tbody>
                {% for p in pisos %}
                    <tr>
                        <td><strong>Piso {{ p.numero }}</strong></td>
                        <td>{{ p.largo }}m x {{ p.ancho }}m x {{ p.alto }}m</td>
                        <td>{{ p.getArea() }} m²</td>
                        <td><strong>{{ p.equipos }}</strong></td>
                        <td>
                            {% if p.sala %}
                                <span class="label label-success">MDF Principal (Cuarto de Equipos)</span>
                            {% else %}
                                <span class="label label-info">IDF Piso {{ p.numero }}</span>
                            {% endif %}
                        </td>
                        <td>{{ p.getCableMetros() }} m</td>
                        <td>{{ p.getCajasUtp() }} caja(s)</td>
                        <td>{{ p.getAccessPoints() }} WAP</td>
                    </tr>
                {% endfor %}
                <tr class="warning">
                    <td colspan="2"><strong>TOTALES EDIFICIO</strong></td>
                    <td><strong>{{ totalArea }} m²</strong></td>
                    <td><strong>{{ totalPuestos }} hosts</strong></td>
                    <td><strong>{{ pisos|length }} Salas (1 MDF + {{ pisos|length - 1 }} IDF)</strong></td>
                    <td><strong>{{ totalMetrosCable }} m</strong></td>
                    <td><strong>{{ totalCajasUtp }} bobinas</strong></td>
                    <td><strong>{{ totalAPs }} WAPs</strong></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- Seccion 3: Diseno Logico y Direccionamiento IP -->
<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title"><strong>3. Diseno Logico y Tabla de Direccionamiento IP (VLSM / CIDR)</strong></h4>
    </div>
    <div class="panel-body">
        <p><strong>Escalabilidad Proyectada:</strong> {{ logico.escalabilidad }}</p>
        <p><strong>Redundancia en Enlaces y Puertas de Enlace:</strong> {{ logico.redundancia ? 'Activada (HSRP / Rapid-PVST+)' : 'Desactivada' }}</p>
        <br>
        <table class="table table-bordered table-striped">
            <thead>
                <tr class="info">
                    <th>VLAN ID</th>
                    <th>Nombre de Subred</th>
                    <th>Segmento de Red / Prefijo</th>
                    <th>Mascara de Subred</th>
                    <th>Default Gateway</th>
                    <th>Rango Asignado / DHCP</th>
                    <th>Proposito y QoS</th>
                </tr>
            </thead>
            <tbody>
                {% for v in vlans %}
                    <tr>
                        <td><span class="label label-primary">VLAN {{ v['vlan_id'] }}</span></td>
                        <td><strong>{{ v['nombre'] }}</strong></td>
                        <td><code>{{ v['red'] }}</code></td>
                        <td>{{ v['mascara'] }}</td>
                        <td><code>{{ v['gateway'] }}</code></td>
                        <td><small>{{ v['rango_dhcp'] }}</small></td>
                        <td>{{ v['proposito'] }}</td>
                    </tr>
                {% endfor %}
            </tbody>
        </table>
    </div>
</div>

<!-- Seccion 4: Inventario y Lista de Materiales (BOM) -->
<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title"><strong>4. Lista de Materiales y Equipamiento (Bill of Materials - BOM)</strong></h4>
    </div>
    <div class="panel-body">
        <table class="table table-bordered table-striped">
            <thead>
                <tr class="info">
                    <th>Dispositivo</th>
                    <th>Referencia Sugerida</th>
                    <th>Capa</th>
                    <th>Cantidad</th>
                    <th>Puertos</th>
                    <th>Ubicacion</th>
                </tr>
            </thead>
            <tbody>
                {% for eq in equipos %}
                    <tr>
                        <td><strong>{{ eq.tipo_equipo }}</strong></td>
                        <td>{{ eq.modelo }}</td>
                        <td>Capa {{ eq.capa_osi }}</td>
                        <td><strong>{{ eq.cantidad }}</strong></td>
                        <td>{{ eq.puertos }}</td>
                        <td>{{ eq.ubicacion }}</td>
                    </tr>
                {% endfor %}
            </tbody>
        </table>
    </div>
</div>

<!-- Seccion 5: Scripts Cisco IOS -->
<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title"><strong>5. Scripts de Configuracion Automatizados (Cisco IOS)</strong></h4>
    </div>
    <div class="panel-body">
        <h4>A. Configuracion Switch de Acceso</h4>
        <pre><code>{{ scriptSwitch }}</code></pre>

        <h4>B. Configuracion Router de Borde / Enrutamiento Inter-VLAN</h4>
        <pre><code>{{ scriptRouter }}</code></pre>
    </div>
</div>
