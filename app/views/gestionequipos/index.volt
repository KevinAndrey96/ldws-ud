<div class="page-header">
    <h2>Gestión de Equipos de Red <small>Dimensionamiento y Lista de Materiales (BOM)</small></h2>
</div>

{{ content() }}

<div class="row">
    <div class="col-md-3">
        <div class="panel panel-primary text-center">
            <div class="panel-heading">
                <h3 class="panel-title">Puestos de Trabajo</h3>
            </div>
            <div class="panel-body">
                <h2><strong>{{ totalPuestos }}</strong></h2>
                <p class="text-muted">Equipos terminales activos</p>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="panel panel-info text-center">
            <div class="panel-heading">
                <h3 class="panel-title">Cableado Horizontal</h3>
            </div>
            <div class="panel-body">
                <h2><strong>{{ totalMetrosCable }}</strong> m</h2>
                <p class="text-muted">{{ totalCajasUtp }} bobinas Cat 6 (305m)</p>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="panel panel-success text-center">
            <div class="panel-heading">
                <h3 class="panel-title">Access Points Wi-Fi</h3>
            </div>
            <div class="panel-body">
                <h2><strong>{{ totalAPs }}</strong></h2>
                <p class="text-muted">Cisco Aironet Wave 2</p>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="panel panel-warning text-center">
            <div class="panel-heading">
                <h3 class="panel-title">Niveles / Pisos</h3>
            </div>
            <div class="panel-body">
                <h2><strong>{{ pisos|length }}</strong></h2>
                <p class="text-muted">Plantas arquitectonicas</p>
            </div>
        </div>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="glyphicon glyphicon-list"></i> Inventario de Hardware Calculado (Top-Down Design)</h3>
    </div>
    <div class="panel-body">
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr class="info">
                    <th>Tipo de Dispositivo</th>
                    <th>Modelo Referencia</th>
                    <th>Capa OSI</th>
                    <th>Cant.</th>
                    <th>Puertos</th>
                    <th>Ubicacion Asignada</th>
                    <th>Funcion en la Red</th>
                </tr>
            </thead>
            <tbody>
                {% if equipos is empty %}
                    <tr>
                        <td colspan="7" class="text-center text-muted">No hay equipos registrados aun. Configure los pisos para generar el dimensionamiento.</td>
                    </tr>
                {% else %}
                    {% for eq in equipos %}
                        <tr>
                            <td><strong>{{ eq.tipo_equipo }}</strong></td>
                            <td>{{ eq.modelo }}</td>
                            <td><span class="label label-primary">Capa {{ eq.capa_osi }}</span></td>
                            <td><strong>{{ eq.cantidad }}</strong></td>
                            <td>{{ eq.puertos }}</td>
                            <td><span class="label label-default">{{ eq.ubicacion }}</span></td>
                            <td><small>{{ eq.descripcion }}</small></td>
                        </tr>
                    {% endfor %}
                {% endif %}
            </tbody>
        </table>
    </div>
</div>

<div class="row">
    <div class="col-md-12 text-right">
        {{ link_to("grafica", "Ver Visualizacion de Pisos &raquo;", "class": "btn btn-info") }}
        {{ link_to("verreportes", "Generar Reporte Tecnico &raquo;", "class": "btn btn-success") }}
    </div>
</div>
