<div class="page-header">
    <h2>Gestión de Solicitudes <small>Proyectos de Diseño de Red LAN</small></h2>
</div>

{{ content() }}

<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="glyphicon glyphicon-folder-open"></i> Solicitudes Registradas</h3>
    </div>
    <div class="panel-body">
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr class="info">
                    <th>Código</th>
                    <th>Empresa</th>
                    <th>Título del Proyecto</th>
                    <th>Servicios Requeridos</th>
                    <th>Observaciones Técnicas</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                {% if datos is empty %}
                    <tr>
                        <td colspan="6" class="text-center text-muted">No hay solicitudes registradas aún. Seleccione una empresa para crear un nuevo proyecto.</td>
                    </tr>
                {% else %}
                    {% for item in datos %}
                        <tr>
                            <td><span class="label label-primary">#{{ item.Solicitud }}</span></td>
                            <td><strong>{{ item.Empresa }}</strong></td>
                            <td>{{ item.Titulo }}</td>
                            <td><small><span class="label label-info">{{ item.Servicio }}</span></small></td>
                            <td><small>{{ item.Observaciones }}</small></td>
                            <td class="text-center">
                                {{ link_to("grafica", "Topología", "class": "btn btn-xs btn-info") }}
                                {{ link_to("gestionequipos", "Equipos", "class": "btn btn-xs btn-warning") }}
                                {{ link_to("verreportes", "Reporte", "class": "btn btn-xs btn-success") }}
                            </td>
                        </tr>
                    {% endfor %}
                {% endif %}
            </tbody>
        </table>
    </div>
</div>

<div class="text-right">
    {{ link_to("empresa/index", "Nueva Solicitud desde Empresa &raquo;", "class": "btn btn-success") }}
</div>
