<div class="page-header">
    <h2 align="center">CREAR SOLICITUD</h2>
</div>

<p>
Bienvenido al módulo de solicitudes, aquí podrá iniciar el proceso de solicitud para su empresa
</p>
{{ form("gestionsolicitud/new", "method":"post") }}
	<input type="hidden" name="IdEmpresa" value="{{ idempresa }}">

	<label>Titulo</label>
	<input type="text" class="form-control" placeholder="Titulo" name="titulo">

	<label>Descripción</label>
	<textarea class="form-control" placeholder="Descripción" name="desc"></textarea>

	<label>Objetivos</label>
	<textarea class="form-control" placeholder="Objetivos" name="obj" ></textarea>

	<label>Observaciones</label>
	<textarea class="form-control" placeholder="Observaciones" name="obs"></textarea>

	<label>Servicios necesarios</label>
	<select class="form-control" placeholder="Servicios Necesarios" name="serv" multiple>
	  <option value="web">WEB</option>
	  <option value="bd">BD</option>
	  <option value="aplicaciones">APLICACIONES</option>
	  <option value="proxi">PROXI</option>
	  <option value="voip">VOIP</option>
	  <option value="video">VIDEO CONFERENCIA</option>
	  <option value="correo">CORREO</option>
	  <option value="dir_activo">DIRECTORIO ACTIVO</option>
	  <option value="dhcp">DHCP</option>
	  <option value="dna">DNS</option>
	  <option value="ftp">FTP</option>
	  <option value="encapsulamiento">ENCAPSULAMIENTO</option>
	  <option value="redundancia">REDUNDANCIA</option>
	</select>
	<p style="font-size:10px">*Mantenga presionado Ctrl (windows) / Command (Mac) para seleccionar varias opciones.</p>
	
	<br>
	<center>{{ submit_button("Guardar", "class": "btn btn-success") }}</center>
{{ end_form() }}