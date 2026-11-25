<div class="page-header">
    <h2>Empresas Clientes <small>Metodología Top-Down: Análisis de Requerimientos</small></h2>
</div>

{{ content() }}

<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="glyphicon glyphicon-briefcase"></i> Empresas Registradas</h3>
    </div>
    <div class="panel-body">
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr class="info">
                    <th>ID</th>
                    <th>Nombre de Empresa</th>
                    <th>NIT</th>
                    <th>Misión</th>
                    <th>Visión</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                {% if datos is empty %}
                    <tr>
                        <td colspan="6" class="text-center text-muted">No hay empresas registradas. Cree la primera empresa para iniciar el diseño de red.</td>
                    </tr>
                {% else %}
                    {% for item in datos %}
                        <tr>
                            <td><span class="label label-primary">#{{ item.id }}</span></td>
                            <td><strong>{{ item.nombre }}</strong></td>
                            <td><code>{{ item.nit }}</code></td>
                            <td><small>{{ item.mision }}</small></td>
                            <td><small>{{ item.vision }}</small></td>
                            <td class="text-center" style="white-space: nowrap;">
                                {{ form("gestionsolicitud/new", "method":"post", "style":"display:inline;") }}
                                    <input type="hidden" name="IdEmpresa" value="{{ item.id }}">
                                    <input type="hidden" name="validar" value="true">
                                    <button type="submit" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-plus"></i> Crear Solicitud</button>
                                {{ end_form() }}
                            </td>
                        </tr>
                    {% endfor %}
                {% endif %}
            </tbody>
        </table>
    </div>
</div>

<div class="text-right">
    {{ link_to("empresa/new", "Registrar Nueva Empresa &raquo;", "class": "btn btn-success") }}
</div>
