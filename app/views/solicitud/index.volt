<div class="page-header">
    <h2>SOLICITUD</h2>
</div>

<p>
Bienvenido al módulo de solicitudes, aquí podrá iniciar el proceso de solicitud para su empresa
</p>
{{ form("solicitud/new", "method":"post", "id" : "form_vehicle", "title" : "form_vehicle") }}
	<label>Titulo</label>
	<input type="text" placeholder="Titulo de la solicitud"  class="form-control" name="">

	<label>Descripción</label>
	<textarea class="form-control" placeholder="Descripción"></textarea>

	<label>Nombre de la empresa</label>
	<input class="form-control" type="text" placeholder="Empresa" name="">

	<label>Misión</label>
	<textarea class="form-control" placeholder="Misión" ></textarea>

	<label>Visión</label>
	<textarea class="form-control" placeholder="Visión" ></textarea>

	<label>Objetivos de la solicitud</label>
	<textarea class="form-control" placeholder="Objetivos" ></textarea>

	<label>Observaciones</label>
	<textarea class="form-control" placeholder="Observaciones" ></textarea>

	<label>Servicios necesarios</label>
	<select class="form-control" placeholder="Servicios Necesarios" >
		<option></option>
	</select>
	
	<br>
	<center><input type="submit" class="btn btn-default" name=""></center>
{{ end_form() }}