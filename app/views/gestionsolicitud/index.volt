<h2 align="center">Gestión de Solicitudes</h2>

<table class="table table-bordered table-striped">
    <thead>
        <tr>
            <td>Codigo Solicitud</td>
            <td>Titulo</td>
            <td>Descripcion</td>
            <td>Observacion</td>
            <!--<td>M</td>
            <td>E</td>-->
        </tr>
    </thead>
    <tbody>
        {% if datos is empty %}

        {% else %}
            {% for item in datos %}
                <tr>
                    <td>{{ item.Solicitud }}</td>
                    <td>{{ item.Titulo }}</td>
                    <td>{{ item.Descripcion }}</td>
                    <td>{{ item.Observaciones }}</td>
                    <!--<td align="right"><input type="checkbox"></td>
                    <td align="right"><input type="checkbox"></td> --> 
                </tr>          
            {% endfor %}                
        {% endif %}
    </tbody>
</table>

<div align="right">
    {{ link_to("empresa/index", "Crear", "class": "btn btn-success") }}
</div>
