<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.dao.UsuarioManager" %>
<%
    // 1. OBTENER EL USUARIO DE LA SESIÓN
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

    // 2. SI NO HAY SESIÓN, ¡AFUERA!
    // (Redirige al login)
    if (usuarioLogueado == null) {
        response.sendRedirect("index.jsp?error=sesion_expirada");
        return;
    }

    // 3. OBTENER EL NOMBRE DE ESTA PÁGINA
    String paginaActual = request.getRequestURI().substring(request.getContextPath().length() + 1);

    // 4. VERIFICAR PERMISO CON EL MANAGER
    if (!UsuarioManager.tieneAccesoPagina(usuarioLogueado, paginaActual)) {
        
        // ¡ACCESO DENEGADO!
        // Redirigimos al usuario a su menú (o una página de error)
        // (Asumiendo que "Menu.jsp" es seguro para todos)
        response.sendRedirect("Menu.jsp?error=acceso_denegado");
        return;
    }

    // Si el código llega hasta aquí, el usuario TIENE PERMISO.
    // La página .jsp se cargará normalmente.
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
            <form action="ReservaServlet" method="post">
                
                <!-- ROW PRINCIPAL: Contiene todos los campos -->
                <div class="row g-4">
                    
                    <!-- COLUMNA IZQUIERDA: DATOS DE RESERVA -->
                    <div class="col-lg-7">
                        
                        <!-- SECCIÓN 1: FECHAS Y HORAS (Títulos en blanco) -->
                        <h4 class="text-white border-bottom border-secondary pb-2 mb-3">Fechas de Reserva</h4>
                        <div class="row g-3 mb-4">
                            <!-- Fecha Entrada -->
                            <div class="col-md-6">
                                <label for="fechaEntrada" class="form-label fw-bold">Fecha de Entrada:</label>
                                <input type="date" class="form-control" id="fechaEntrada" name="fechaEntrada" required>
                            </div>
                            <!-- Hora Entrada -->
                            <div class="col-md-6">
                                <label for="horaEntrada" class="form-label fw-bold">Hora:</label>
                                <input type="time" class="form-control" id="horaEntrada" name="horaEntrada">
                            </div>

                            <!-- Fecha Salida -->
                            <div class="col-md-6">
                                <label for="fechaSalida" class="form-label fw-bold">Fecha de Salida:</label>
                                <input type="date" class="form-control" id="fechaSalida" name="fechaSalida" required>
                            </div>
                            <!-- Hora Salida -->
                            <div class="col-md-6">
                                <label for="horaSalida" class="form-label fw-bold">Hora:</label>
                                <input type="time" class="form-control" id="horaSalida" name="horaSalida">
                            </div>
                        </div>

                        <!-- SECCIÓN 2: DETALLES DE HABITACIÓN (Títulos en blanco) -->
                        <h4 class="text-white border-bottom border-secondary pb-2 mb-3">Detalles de Habitación</h4>
                        <div class="row g-3 mb-4">
                            <!-- Tipo de Habitación -->
                            <div class="col-md-6">
                                <label for="tipoHabitacion" class="form-label fw-bold">Tipo de Habitación:</label>
                                <select class="form-select" id="tipoHabitacion" name="tipoHabitacion" required>
                                    <option value="" selected disabled>Seleccione...</option>
                                    <option value="simple">Simple</option>
                                    <option value="doble">Doble</option>
                                    <option value="suite">Suite</option>
                                </select>
                            </div>
                            <!-- Número de Huéspedes -->
                            <div class="col-md-6">
                                <label for="numHuespedes" class="form-label fw-bold">Número de Huéspedes:</label>
                                <input type="number" class="form-control" id="numHuespedes" name="numHuespedes" min="1" value="1" required>
                            </div>
                            <!-- Habitación Asignada (Campo de búsqueda/lectura) -->
                            <div class="col-12">
                                <label for="habitacionAsignada" class="form-label fw-bold">Habitación Asignada (Búsqueda):</label>
                                <input type="text" class="form-control" id="habitacionAsignada" name="habitacionAsignada" placeholder="Automáticamente al hacer clic en 'Buscar'">
                            </div>
                        </div>

                        <!-- SECCIÓN 3: PAGO Y ESTADO (Títulos en blanco) -->
                        <h4 class="text-white border-bottom border-secondary pb-2 mb-3">Información de Pago</h4>
                        <div class="row g-3">
                            <!-- Método de Pago -->
                            <div class="col-md-6">
                                <label for="metodoPago" class="form-label fw-bold">Método de Pago:</label>
                                <select class="form-select" id="metodoPago" name="metodoPago" required>
                                    <option value="efectivo">Efectivo</option>
                                    <option value="tarjeta">Tarjeta de Crédito/Débito</option>
                                    <option value="transferencia">Transferencia</option>
                                </select>
                            </div>
                            <!-- Estado de Reserva -->
                            <div class="col-md-6">
                                <label for="estadoReserva" class="form-label fw-bold">Estado de Reserva:</label>
                                <select class="form-select" id="estadoReserva" name="estadoReserva">
                                    <option value="pendiente">Pendiente</option>
                                    <option value="confirmada" selected>Confirmada</option>
                                    <option value="cancelada">Cancelada</option>
                                </select>
                            </div>
                        </div>
                        
                    </div>
                    
                    <!-- COLUMNA DERECHA: DATOS DEL HUÉSPED Y BOTONES -->
                    <div class="col-lg-5 border-start border-secondary ps-lg-4">
                        
                        <!-- SECCIÓN 4: DATOS DEL HUÉSPED (Título en blanco) -->
                        <h4 class="text-white border-bottom border-secondary pb-2 mb-3">Datos del Huésped</h4>

                        <div class="mb-3">
                            <label for="cedulaHuesped" class="form-label fw-bold">Cédula:</label>
                            <!-- Línea 144 aprox -->
                            <input type="text" class="form-control" id="cedula" name="cedula" required placeholder="Ingrese cédula existente">
                        </div>
                        
                        <div class="mb-3">
                            <label for="nombreHuesped" class="form-label fw-bold">Nombre:</label>
                            <input type="text" class="form-control" id="nombreHuesped" name="nombreHuesped">
                        </div>
                        
                        <div class="mb-3">
                            <label for="apellidoHuesped" class="form-label fw-bold">Apellido:</label>
                            <input type="text" class="form-control" id="apellidoHuesped" name="apellidoHuesped">
                        </div>
                        
                        <div class="mb-3">
                            <label for="telefonoHuesped" class="form-label fw-bold">Teléfono:</label>
                            <input type="text" class="form-control" id="telefonoHuesped" name="telefonoHuesped">
                        </div>
                        
                        <!-- SECCIÓN 5: BOTONES PRINCIPALES -->
                        <div class="botones-crud mt-4"> 
                            <!-- Botón Reservar: Color Azul Primario -->
                           <button type="submit" name="accion" value="Reservar" class="btn btn-primary">Reservar</button>
                            <!-- Botón Buscar: Color Gris Secundario -->
                            <button type="submit" name="accion" value="Buscar" class="btn btn-secondary btn-custom-width">Buscar</button>
                            <!-- Botón Cancelar: Color Gris Secundario -->
                            <button type="submit" name="accion" value="Eliminar" class="btn btn-secondary btn-custom-width">Eliminar</button>
                            <!-- Botón Nuevo: Color Gris Secundario -->
                            <button type="button" onclick="window.location.reload();" class="btn btn-secondary btn-custom-width">Nuevo</button>
                            
                                  <!-- NUEVO BOTÓN DE REGRESO AL MENÚ -->
                            <button type="button" onclick="window.location.href='Menu.jsp';" class="btn btn-secondary btn-custom-width">Regresar</button>
                        </div>
                        
                    </div>
                </div>
            </form>
        </div>
        
        <!-- Pie de página opcional para la tarjeta -->
        <div class="card-footer text-end text-muted py-2 bg-black rounded-bottom-3">
            <small>Sistema de Gestión de Reservas Hoteleras</small>
        </div>
    </div>
    
    <!-- JavaScript de BOOTSTRAP -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>