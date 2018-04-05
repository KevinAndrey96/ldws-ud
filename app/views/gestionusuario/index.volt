{{ content() }}

<!-- <ul class="pager">
    <li class="next">
        {{ link_to("register/index", "Crear Usuario") }}
    </li>
</ul> -->
<br><br>
<table class="table table-bordered table-striped" align="center">
    <thead>
        <tr>
            <th>Id</th>
            <th>Nombre</th>
            <th>Email</th>
            <th>Teléfono</th>
            <th>Rol</th>
            <th>Activo</th>
            <th>Editar</th>
            <th>Eliminar</th>
        </tr>
    </thead>
    <tbody>
    {% for user in datos %}
        <tr>
            <td>{{ user.id }}</td>
            <td>{{ user.name }}</td>
            <td>{{ user.email }}</td>
            <td>{{ user.telefono }}</td>
            <td>{{ user.rol_idrol == '1' ? 'Administrador' : 'Usuario'}}</td>
            <td>{{ user.active == 'Y' ? 'Si' : 'No' }}</td>
            <td width="7%">{{ link_to("gestionusuario/edit/" ~ user.id, '<i class="glyphicon glyphicon-edit"></i>', "class": "btn") }}</td>
            <td width="7%">{{ link_to("gestionusuario/delete/" ~ user.id, '<i class="glyphicon glyphicon-remove"></i>', "class": "btn") }}</td>
        </tr>
    {% endfor %}
    </tbody>
</table>
