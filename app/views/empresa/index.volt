<h2 align="center">Empresas</h2>

<table class="table table-bordered table-striped">
    <thead>
        <tr>
            <td>Nombre</td>
            <td>Visión</td>
            <td>Misión</td>
            <td>Nit</td>
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
                </tr>          
            {% endfor %}                
        {% endif %}
    </tbody>
</table>

<div align="right">
    {{ link_to("empresa/new", "Crear", "class": "btn btn-success") }}
</div>
