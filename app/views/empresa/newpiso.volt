<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous">{{ link_to("gestionsolicitud/new", "Volver") }}</li>
        </ul>
    </nav>
</div>


<div class="page-header">
    <h2>Fisíco</h2>
</div>

<p>
Por favor ingrese los datos para el registro fisíco de su empresa
</p>
{{ form("empresa/newpiso", "method":"post") }}

	<label>Alto</label>
	<input class="form-control" type="number" placeholder="Alto" name="alto" required="">

	<label>Ancho</label>
	<input type="number" placeholder="Ancho" class="form-control" name="ancho" required="">

	<label>Largo</label>
	<input class="form-control" type="number" placeholder="Largo" name="largo" required="">

	<label>Número de Equipos</label>
	<input class="form-control" type="number" placeholder="Número de Equipos" name="equipos" required="">

	<br>
	<label>Sala</label>
	<input type="checkbox" placeholder="sala" name="sala">

	<br>
	<div class="row">
		<div class="col-md-6"><center>{{ submit_button("Agregar piso", "class": "btn btn-success") }}</center></div>
		<div class="col-md-6"><center>
			<a href="{{ url('empresa/newlogico') }}"><input class="btn btn-success" type="button" value="Continuar"/></a></center>
		</div>
	</div>
	
	
{{ end_form() }}

