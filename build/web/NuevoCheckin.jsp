<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.models.Checkin" %>

<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
    if (usuarioLogueado == null) {
        response.sendRedirect("index.jsp?error=sesion_expirada");
        return;
    }

    // RECUPERAR DATOS SI VENIMOS DE BUSCAR
    Checkin c = (Checkin) request.getAttribute("checkinEncontrado");
    
    // Variables de data binding
    String fEntrada = (c != null) ? c.getFechaEntrada() : "";
    String hEntrada = (c != null) ? c.getHoraEntrada() : "14:00";
    String fSalida  = (c != null) ? c.getFechaSalida() : "";
    String hSalida  = (c != null) ? c.getHoraSalida() : "12:00";
    String tiempo   = (c != null) ? c.getTiempoEstadia() : "";
    String numHab   = (c != null) ? c.getNumHabitacion() : "";
    String tipoHab  = (c != null) ? c.getTipoHabitacion() : "";
    String precio   = (c != null) ? String.valueOf(c.getPrecioNoche()) : "0.0";
    String total    = (c != null) ? String.valueOf(c.getCostoTotal()) : "0.0";
    
    String cedulaVal   = (c != null) ? c.getClienteCedula() : "";
    String nombreVal   = (c != null) ? c.getClienteNombre() : "";
    String apellidoVal = (c != null) ? c.getClienteApellido() : "";
    String telefonoVal = (c != null) ? c.getClienteTelefono() : "";
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nuevo Check-in (Bootstrap Dark)</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body { background-color: #343a40; min-height: 100vh; display: flex; justify-content: center; align-items: center; padding: 20px 0; }
        .form-dark-card { max-width: 900px; width: 95%; background-color: #212529; border: none; }
        .form-control, .form-select { background-color: #495057; color: #fff; border-color: #6c757d; }
        .form-control:read-only { background-color: #343a40; opacity: 0.9; }
    </style>
</head>
<body>
    
    <div class="card form-dark-card text-white shadow-lg rounded-3">
        <div class="card-header bg-black text-center py-3 rounded-top-3">
            <h2 class="mb-0">Registro de Check-in</h2>
        </div>
        
        <div class="card-body">
            <% 
                String msj = (String) request.getAttribute("mensaje");
                String err = (String) request.getAttribute("error");
                if(msj!=null) out.print("<div class='alert alert-success'>"+msj+"</div>");
                if(err!=null) out.print("<div class='alert alert-danger'>"+err+"</div>");
            %>

            <form action="CheckinServlet" method="post">
                <div class="row mb-4 border-bottom border-secondary pb-3">
                    <div class="col-md-6 offset-md-3">
                        <div class="input-group">
                            <input type="text" class="form-control border-success" name="cedula" value="<%= cedulaVal %>" placeholder="Ingrese Cédula de Reserva">
                            <button class="btn btn-success" type="submit" name="accion" value="buscar_reserva">Buscar Reserva</button>
                        </div>
                        <small class="text-muted">Busque para autocompletar datos y calcular costos.</small>
                    </div>
                </div>

                <div class="row g-4">
                    <div class="col-lg-6">
                        <h5 class="text-white mb-3">Detalles de Estancia</h5>
                        <div class="row g-2">
                            <div class="col-6">
                                <label>Fecha Entrada</label>
                                <input type="text" class="form-control" name="fechaEntrada" value="<%= fEntrada %>" readonly>
                            </div>
                            <div class="col-6">
                                <label>Hora</label>
                                <input type="text" class="form-control" name="horaEntrada" value="<%= hEntrada %>">
                            </div>
                            <div class="col-6">
                                <label>Fecha Salida</label>
                                <input type="text" class="form-control" name="fechaSalida" value="<%= fSalida %>" readonly>
                            </div>
                            <div class="col-6">
                                <label>Hora</label>
                                <input type="text" class="form-control" name="horaSalida" value="<%= hSalida %>">
                            </div>
                            
                            <div class="col-12 mt-3">
                                <label class="text-info fw-bold">Tiempo Estadía (Calculado):</label>
                                <input type="text" class="form-control text-info fw-bold" name="tiempoEstadia" value="<%= tiempo %>" readonly>
                            </div>
                        </div>

                        <h5 class="text-white mt-4 mb-3">Habitación y Costos</h5>
                        <div class="row g-2">
                            <div class="col-6">
                                <label>N° Habitación</label>
                                <input type="text" class="form-control" name="numHabitacion" value="<%= numHab %>" readonly>
                            </div>
                            <div class="col-6">
                                <label>Tipo</label>
                                <input type="text" class="form-control" name="tipoHabitacion" value="<%= tipoHab %>" readonly>
                            </div>
                            <div class="col-6">
                                <label>Precio Noche</label>
                                <input type="text" class="form-control" name="precioNoche" value="<%= precio %>" readonly>
                            </div>
                            <div class="col-6">
                                <label class="text-success fw-bold">Costo Total</label>
                                <input type="text" class="form-control border-success text-success fw-bold" name="costoTotal" value="<%= total %>" readonly>
                            </div>
                            <div class="col-12 mt-2">
                                <label>Estado de Pago</label>
                                <select class="form-select" name="estadoPago">
                                    <option value="Pendiente">Pendiente (Pagar al Salir)</option>
                                    <option value="Adelanto">Dejó Adelanto</option>
                                    <option value="Pagado">Pagado Completo</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 border-start border-secondary ps-4">
                        <h5 class="text-white mb-3">Datos del Huésped</h5>
                        <div class="mb-3">
                            <label>Nombre Completo</label>
                            <input type="text" class="form-control" name="nombre" value="<%= nombreVal %>" readonly>
                        </div>
                        <div class="mb-3">
                            <label>Apellidos</label>
                            <input type="text" class="form-control" name="apellido" value="<%= apellidoVal %>" readonly>
                        </div>
                        <div class="mb-3">
                            <label>Teléfono</label>
                            <input type="text" class="form-control" name="telefono" value="<%= telefonoVal %>" readonly>
                        </div>
                        <div class="mb-3">
                            <label>Observaciones Check-in</label>
                            <textarea class="form-control" name="observaciones" rows="3"></textarea>
                        </div>

                        <div class="d-grid gap-2 mt-4">
                            <button type="submit" name="accion" value="guardar_checkin" class="btn btn-primary btn-lg">Registrar Check-in</button>
                            <a href="Menu.jsp" class="btn btn-info">Regresar al Menú</a>
                        </div>
                    </div>
                        <div class="watermark">
        <i class="fas fa-code"></i>By Melanny G & Camilo R
    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>