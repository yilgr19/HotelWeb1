<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.dao.UsuarioManager" %>
<%@ page import="hotelweb.models.Reserva" %>
<%@ page import="hotelweb.models.Cliente" %>

<%
    // 1. SEGURIDAD
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
    if (usuarioLogueado == null) {
        response.sendRedirect("index.jsp?error=sesion_expirada");
        return;
    }

    // 2. RECUPERAR DATOS
    Reserva reservaFound = (Reserva) request.getAttribute("reservaEncontrada");
    Cliente clienteFound = (Cliente) request.getAttribute("clienteEncontrado");
    String mensajeServidor = (String) request.getAttribute("mensaje");

    // --- LÓGICA DE LIMPIEZA AUTOMÁTICA ---
    // Detectamos si la acción fue eliminar. Si el mensaje dice "eliminada", 
    // forzamos que todas las variables se queden vacías para empezar de cero.
    boolean fueEliminado = (mensajeServidor != null && mensajeServidor.toLowerCase().contains("eliminada"));

    // 3. PREPARAR VARIABLES (Data Binding)
    // Solo llenamos datos si NO fue eliminado y si encontramos una reserva.
    String fechaEntradaVal = (!fueEliminado && reservaFound != null && reservaFound.getFechaEntrada() != null) ? reservaFound.getFechaEntrada() : "";
    String horaEntradaVal  = (!fueEliminado && reservaFound != null && reservaFound.getHoraEntrada() != null) ? reservaFound.getHoraEntrada() : "14:00";
    String fechaSalidaVal  = (!fueEliminado && reservaFound != null && reservaFound.getFechaSalida() != null) ? reservaFound.getFechaSalida() : "";
    String horaSalidaVal   = (!fueEliminado && reservaFound != null && reservaFound.getHoraSalida() != null) ? reservaFound.getHoraSalida() : "12:00";
    String habAsignadaVal  = (!fueEliminado && reservaFound != null && reservaFound.getHabitacionAsignada() != null) ? reservaFound.getHabitacionAsignada() : "";
    int numHuespedesVal    = (!fueEliminado && reservaFound != null) ? reservaFound.getNumHuespedes() : 1;
    
    // Cédula: Se limpia si fue eliminado.
    String cedulaVal = "";
    if (!fueEliminado) {
        if (reservaFound != null && reservaFound.getCedulaCliente() != null) {
            cedulaVal = reservaFound.getCedulaCliente();
        } else if (request.getParameter("cedula") != null) {
            cedulaVal = request.getParameter("cedula");
        }
    }

    // Datos Cliente: Se limpian si fue eliminado.
    String nombreVal   = (!fueEliminado && clienteFound != null && clienteFound.getNombre() != null) ? clienteFound.getNombre() : "";
    String apellidoVal = (!fueEliminado && clienteFound != null && clienteFound.getApellido() != null) ? clienteFound.getApellido() : "";
    String telefonoVal = (!fueEliminado && clienteFound != null && clienteFound.getTelefono() != null) ? clienteFound.getTelefono() : "";
%>



<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nueva Reserva de Hotel (Bootstrap Dark)</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- CSS de BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <style>
        /* Estilos base para centrar la tarjeta de reserva en la página */
        body {
            /* Fondo oscuro para la consistencia del sistema */
            background-color: #343a40; 
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px 0; /* Añadir padding para pantallas pequeñas */
        }

        /* Estilo para el contenedor del formulario que lo hace oscuro */
        .form-dark-card {
            max-width: 900px; /* Hacemos la tarjeta más ancha para los campos de reserva */
            width: 95%;
            /* Fondo gris oscuro, similar al formulario de Cliente/Habitación */
            background-color: #212529; 
            border: none;
        }

        /* Estilo para los inputs, select y textarea para que contrasten mejor */
        .form-control, .form-select {
            background-color: #495057; /* Fondo de campo gris oscuro */
            color: #fff; /* Texto blanco en los campos */
            border-color: #6c757d;
        }

        .form-control:focus, .form-select:focus {
            background-color: #495057;
            color: #fff;
            border-color: #0d6efd; 
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        
        /* Ajuste para que los botones de CRUD sean del mismo tamaño */
        .btn-custom-width {
            width: 100px; 
            height: 40px;
        }

        /* Alineación y espaciado de los grupos de botones de la derecha */
        .botones-crud {
            display: flex;
            flex-direction: column;
            gap: 10px;
            padding-top: 20px; 
        }
        
        /* Estilo personalizado para el botón de Reservar (Azul Primario) */
        .btn-reservar {
            background-color: #0d6efd; /* Color azul de Bootstrap Primary */
            border-color: #0d6efd;
            color: white;
        }
        .btn-reservar:hover {
            background-color: #0b5ed7; /* Azul ligeramente más oscuro al pasar el ratón */
            border-color: #0a58ca;
        }
    </style>
</head>
<body>
    
    <!-- Contenedor principal: Tarjeta oscura (TEXT-WHITE) con sombra -->
    <div class="card form-dark-card text-white shadow-lg rounded-3">
        
        <!-- Título/Cabecera de la Tarjeta (BG-BLACK) -->
        <div class="card-header bg-black text-center py-3 rounded-top-3">
            <h2 class="mb-0">Crear Nueva Reserva</h2>
        </div>
        
        <div class="card-body">
            <% 
                String error = (String) request.getAttribute("error");
                String mensaje = (String) request.getAttribute("mensaje");
                
                if (error != null) {
                    out.println("<div class='alert alert-danger' role='alert'>" + error + "</div>");
                }
                if (mensaje != null) {
                    out.println("<div class='alert alert-success' role='alert'>" + mensaje + "</div>");
                }
            %>
            
             <% if (!fueEliminado && reservaFound != null && clienteFound == null && reservaFound.getClienteNombre() == null) { %>
                 <div class="alert alert-warning text-center small">
                     <strong>⚠ ATENCIÓN:</strong> Datos del cliente no encontrados. Complete los campos manualmante.
                </div>
            <% } %>

             <form action="ReservaServlet" method="post">
                <div class="row g-4">
                    
                    <div class="col-lg-7">
                        <h4 class="text-white border-bottom border-secondary pb-2 mb-3">Fechas de Reserva</h4>
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Fecha de Entrada:</label>
                                <input type="text" class="form-control" name="fechaEntrada" value="<%= fechaEntradaVal %>" required placeholder="dd/mm/yyyy">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Hora:</label>
                                <input type="text" class="form-control" name="horaEntrada" value="<%= horaEntradaVal %>">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Fecha de Salida:</label>
                                <input type="text" class="form-control" name="fechaSalida" value="<%= fechaSalidaVal %>" required placeholder="dd/mm/yyyy">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Hora:</label>
                                <input type="text" class="form-control" name="horaSalida" value="<%= horaSalidaVal %>">
                            </div>
                        </div>

                        <h4 class="text-white border-bottom border-secondary pb-2 mb-3">Detalles de Habitación</h4>
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Tipo de Habitación:</label>
                                <select class="form-select" name="tipoHabitacion" required>
                                    <option value="" disabled <%= (reservaFound==null || fueEliminado)?"selected":"" %>>Seleccione...</option>
                                    <option value="simple" <%= (!fueEliminado && reservaFound!=null && "simple".equalsIgnoreCase(reservaFound.getTipoHabitacion()))?"selected":"" %>>Simple</option>
                                    <option value="doble" <%= (!fueEliminado && reservaFound!=null && "doble".equalsIgnoreCase(reservaFound.getTipoHabitacion()))?"selected":"" %>>Doble</option>
                                    <option value="suite" <%= (!fueEliminado && reservaFound!=null && "suite".equalsIgnoreCase(reservaFound.getTipoHabitacion()))?"selected":"" %>>Suite</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Número de Huéspedes:</label>
                                <input type="number" class="form-control" name="numHuespedes" min="1" value="<%= numHuespedesVal %>" required>
                            </div>
                            
                            <div class="col-12">
                                <label class="form-label fw-bold">Habitación Asignada:</label>
                                <input type="text" class="form-control text-info fw-bold" 
                                       name="habitacionAsignada" 
                                       value="<%= (habAsignadaVal == null || habAsignadaVal.isEmpty()) ? "Asignación Automática al Reservar" : habAsignadaVal %>" 
                                       readonly>
                                <small class="text-secondary">El sistema buscará una habitación disponible automáticamente.</small>
                            </div>
                        </div>

                        <h4 class="text-white border-bottom border-secondary pb-2 mb-3">Información de Pago</h4>
                         <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Método de Pago:</label>
                                <select class="form-select" name="metodoPago" required>
                                    <option value="efectivo" <%= (!fueEliminado && reservaFound!=null && "efectivo".equalsIgnoreCase(reservaFound.getMetodoPago()))?"selected":"" %>>Efectivo</option>
                                    <option value="tarjeta" <%= (!fueEliminado && reservaFound!=null && "tarjeta".equalsIgnoreCase(reservaFound.getMetodoPago()))?"selected":"" %>>Tarjeta</option>
                                    <option value="transferencia" <%= (!fueEliminado && reservaFound!=null && "transferencia".equalsIgnoreCase(reservaFound.getMetodoPago()))?"selected":"" %>>Transferencia</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Estado de Reserva:</label>
                                <select class="form-select" name="estadoReserva">
                                    <option value="Confirmada" <%= (!fueEliminado && reservaFound!=null && "Confirmada".equalsIgnoreCase(reservaFound.getEstadoReserva()))?"selected":"" %>>Confirmada</option>
                                    <option value="Pendiente" <%= (!fueEliminado && reservaFound!=null && "Pendiente".equalsIgnoreCase(reservaFound.getEstadoReserva()))?"selected":"" %>>Pendiente</option>
                                    <option value="Cancelada" <%= (!fueEliminado && reservaFound!=null && "Cancelada".equalsIgnoreCase(reservaFound.getEstadoReserva()))?"selected":"" %>>Cancelada</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-5 border-start border-secondary ps-lg-4">
                        
                        <h4 class="text-white border-bottom border-secondary pb-2 mb-3">Datos del Huésped</h4>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold text-warning">Cédula:</label>
                            <input type="text" class="form-control border-warning" id="cedula" name="cedula" value="<%= cedulaVal %>" required placeholder="Ingrese Cédula y presione Buscar">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Nombre:</label>
                            <input type="text" class="form-control" name="nombre" value="<%= nombreVal %>" placeholder="Nombre del cliente" required>
                        </div>
                         <div class="mb-3">
                            <label class="form-label fw-bold">Apellido:</label>
                            <input type="text" class="form-control" name="apellido" value="<%= apellidoVal %>" placeholder="Apellido del cliente" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Teléfono:</label>
                            <input type="text" class="form-control" name="telefono" value="<%= telefonoVal %>" placeholder="Teléfono de contacto" required>
                        </div>
                        
                        <div class="botones-crud mt-4"> 
                            <button type="submit" name="accion" value="Reservar" class="btn btn-reservar">Reservar</button>
                            <div class="d-flex gap-2">
                                <button type="submit" name="accion" value="Buscar" class="btn btn-info flex-fill text-white" formnovalidate>Buscar</button>
                                <button type="submit" name="accion" value="Eliminar" class="btn btn-danger flex-fill" onclick="return confirm('¿Seguro que desea eliminar esta reserva?');" formnovalidate>Eliminar</button>
                            </div>
                            <a href="NuevaReserva.jsp" class="btn btn-secondary mt-2 text-decoration-none text-center">Nuevo / Limpiar Campos</a>
                            <button type="button" onclick="window.location.href='Menu.jsp';" class="btn btn-secondary mt-2 btn-custom-width" style="width: 100%">Regresar</button>
                        </div>
                        
                    </div>
                </div>
            </form>
        </div>
        <div class="card-footer text-end text-muted py-2 bg-black rounded-bottom-3">
            <small>Sistema de Gestión de Reservas Hoteleras</small>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>