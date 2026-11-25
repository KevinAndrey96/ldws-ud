<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous">{{ link_to("empresa/newpiso", "Volver") }}</li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h2>Logíco</h2>
</div>

<p>
Por favor ingrese los datos para el registro logíco de su empresa
</p>
{{ form("empresa/newlogico", "method":"post") }}
	<label>Redundancia</label>
	<input type="checkbox" placeholder="Redundancia" name="redundancia">
	<br>
	<br>

	<label>Escalabilidad</label>
	<input class="form-control" type="text" placeholder="Escalabilidad" name="escalabilidad" required="">

	<label>Subredes</label>
	<input type="number" placeholder="Subredes" class="form-control" name="subredes" required="">

	<label>Descripción Subred</label>
	<input class="form-control" type="text" placeholder="Descripción Subred" name="desc" required="">

	<br>
	<label>Scripts</label>
	<input type="checkbox" placeholder="script" name="script">
	<br>

	<br>
	<label>Tabla Dirección IP</label>
	<input type="checkbox" placeholder="ip" name="ip">
	<br>

	<center>{{ submit_button("Guardar", "class": "btn btn-success") }}</center>
{{ end_form() }}

