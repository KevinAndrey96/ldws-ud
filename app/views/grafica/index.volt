<div class="page-header">
    <h2>Visualización Multinivel del Edificio <small>Topología Física de Red por Pisos</small></h2>
</div>

{{ content() }}

<p class="lead">
    Estructura arquitectónica y distribución de salas de telecomunicaciones (MDF / IDF) por nivel corporativo.
</p>

<div class="row">
    <div class="col-md-7">
        <div class="panel panel-default">
            <div class="panel-heading text-center">
                <h3 class="panel-title"><strong>Vista de Elevación del Edificio</strong></h3>
            </div>
            <div class="panel-body text-center" style="background-color: #f7f9fa; padding: 25px;">
                {% for p in pisos %}
                    <div class="piso-container" style="position: relative; margin-bottom: 2px;">
                        {% if p.numero == 1 %}
                            {{ image("images/piso1.png", "class":"img-responsive center-block", "style":"max-height: 120px;") }}
                        {% else %}
                            {{ image("images/pison.png", "class":"img-responsive center-block", "style":"max-height: 120px;") }}
                        {% endif %}
                        <div class="piso-overlay">
                            <span class="label label-primary" style="font-size: 14px;">Piso {{ p.numero }}</span>
                            {% if p.sala %}
                                <span class="label label-success">MDF Principal</span>
                            {% else %}
                                <span class="label label-info">IDF Piso {{ p.numero }}</span>
                            {% endif %}
                            <span class="label label-default">{{ p.equipos }} puestos</span>
                        </div>
                    </div>
                {% endfor %}
            </div>
        </div>
    </div>

    <div class="col-md-5">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-info-sign"></i> Parámetros Técnicos por Nivel</h3>
            </div>
            <div class="panel-body" style="max-height: 550px; overflow-y: auto;">
                {% for p in pisos %}
                    <div class="well well-sm">
                        <h4><strong>Nivel {{ p.numero }}</strong>
                            {% if p.sala %}
                                <small><span class="label label-success">Sala Principal (MDF)</span></small>
                            {% else %}
                                <small><span class="label label-info">Armario Intermedio (IDF)</span></small>
                            {% endif %}
                        </h4>
                        <ul class="list-unstyled">
                            <li><i class="glyphicon glyphicon-resize-horizontal"></i> <strong>Dimensiones:</strong> {{ p.largo }}m x {{ p.ancho }}m x {{ p.alto }}m ({{ p.getArea() }} m²)</li>
                            <li><i class="glyphicon glyphicon-user"></i> <strong>Puestos de Trabajo:</strong> {{ p.equipos }} terminales</li>
                            <li><i class="glyphicon glyphicon-transfer"></i> <strong>Cableado Horizontal:</strong> {{ p.getCableMetros() }} m UTP Cat 6 ({{ p.getCajasUtp() }} bobinas)</li>
                            <li><i class="glyphicon glyphicon-signal"></i> <strong>Access Points Wi-Fi:</strong> {{ p.getAccessPoints() }} WAP sugeridos</li>
                            <li><i class="glyphicon glyphicon-hdd"></i> <strong>Switches 24p:</strong> {{ p.getSwitchesAcceso() }} unidad(es) requerida(s)</li>
                        </ul>
                    </div>
                {% endfor %}
            </div>
        </div>
        <div class="text-right">
            {{ link_to("empresa/newpiso", "Agregar otro piso", "class": "btn btn-default") }}
            {{ link_to("gestionequipos", "Ver Equipos &raquo;", "class": "btn btn-success") }}
        </div>
    </div>
</div>

<style>
.piso-container {
    position: relative;
    text-align: center;
}
.piso-overlay {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: rgba(255, 255, 255, 0.85);
    padding: 6px 14px;
    border-radius: 6px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.15);
}
</style>
