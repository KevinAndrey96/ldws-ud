<div class="page-header">
    <h2>Gestión de Usuarios <small>Control de Acceso y Roles</small></h2>
</div>

{{ content() }}

<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="glyphicon glyphicon-user"></i> Usuarios Registrados en el Sistema</h3>
    </div>
    <div class="panel-body">
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr class="info">
                    <th>ID</th>
                    <th>Nombre Completo</th>
                    <th>Usuario</th>
                    <th>Correo Electrónico</th>
                    <th>Rol</th>
                    <th>Estado</th>
                    <th>Fecha Registro</th>
                </tr>
            </thead>
            <tbody>
                {% if users is empty %}
                    <tr>
                        <td colspan="7" class="text-center text-muted">No hay usuarios registrados.</td>
                    </tr>
                {% else %}
                    {% for u in users %}
                        <tr>
                            <td>{{ u.id }}</td>
                            <td><strong>{{ u.name }}</strong></td>
                            <td><code>{{ u.username }}</code></td>
                            <td>{{ u.email }}</td>
                            <td>
                                {% if u.role == 'Admin' %}
                                    <span class="label label-danger">Administrador</span>
                                {% else %}
                                    <span class="label label-primary">{{ u.role ? u.role : 'Investigador' }}</span>
                                {% endif %}
                            </td>
                            <td>
                                {% if u.active == 'Y' %}
                                    <span class="label label-success">Activo</span>
                                {% else %}
                                    <span class="label label-default">Inactivo</span>
                                {% endif %}
                            </td>
                            <td><small>{{ u.created_at }}</small></td>
                        </tr>
                    {% endfor %}
                {% endif %}
            </tbody>
        </table>
    </div>
</div>

<div class="text-right">
    {{ link_to("gestionusuario/new", "Crear Nuevo Usuario", "class": "btn btn-success") }}
</div>
