<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous">{{ link_to("index", "Volver") }}</li>
        </ul>
    </nav>
</div>

<h2 align="center">Empresas</h2>

<table class="table table-bordered table-striped">
    <thead>
        <tr>
            <td>Nombre</td>
            <td>Visión</td>
            <td>Misión</td>
            <td>Nit</td>
            <td>Acción</td>
        </tr>
    </thead>
    <tbody>
        {% if datos is empty %}

        {% else %}
            {% for item in datos %}
                <tr>
                    <td>{{ item.nombre }}</td>
                    <td>{{ item.vision }}</td>
                    <td>{{ item.mision }}</td>
                    <td>{{ item.nit }}</td>  
                    <td>
                        {{ form("gestionsolicitud/new", "method":"post") }}
                            <input type="hidden" name="IdEmpresa" value="{{ item.id }}">
                            <input type="hidden" name="validar" value="true">
                            <input style="font-size:11px" type="submit" class="btn btn-primary" value="Crear Solicitud">
                        {{ end_form() }}
                    </td>  
                </tr>          
            {% endfor %}                
        {% endif %}
    </tbody>
</table>

<div align="right">
    {{ link_to("empresa/new", "Crear", "class": "btn btn-success") }}
</div>
