<title>Asignar empleados</title>
<ul class="pager">
        <li class="previous pull-left">
            {{ link_to("gestionusuario", "&larr; Atras") }}
        </li>
    </ul>
<div align="left">
    <h1>Editar Usuario</h1>
</div>

{{ form("gestionusuario/edit", "method":"post") }}
<table class="table table-stripped">
    <thead>
        <tr>
            <th colspan="2" style="text-align:center">
                Usuario {{ user.name }}
            </th>
        </tr>
    </thead>
    <tbody>
            <tr>
                <th>
                    ID
                </th>
                <td>
                    <input type="hidden" name="id" id="nombres" value="{{ user.id }}">
                    {{ user.id }}
                </td>
            </tr>
            <tr>
                <th>
                    Nombre
                </th>
                <td>
                    <input type="text" name="name" id="nombres" value="{{ user.name }}">
                </td>
            </tr>
            <tr>
                <th>
                    Correo
                </th>
                <td>
                    <input type="text" name="email" id="nombres" value="{{ user.email }}">
                </td>
            </tr>
            <tr>
                <th>
                    Teléfono
                </th>
                <td>
                    <input type="text" name="phone" id="nombres" value="{{ user.telefono }}">
                </td>
            </tr>
            <tr>
                <th>
                    Rol
                </th>
                <td>
                    {{ select("id_rol", roles, "using":["id", "nombre"]) }}
                </td>
            </tr>
            <tr>
                <th>
                    Activo
                </th>
                <td>  
                    <select id="active" name="active">
                        <option value="Y">Si</option>
                        <option value="N">No</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th colspan="10" style="text-align:center">
                    <input type="submit" class="btn btn-success"  value="Actualizar" name="enviar">
                </th>
            </tr>
    </tbody>
</table>
{{ end_form() }}
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.0.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#active").val('{{ user.active }}');
    });
</script>