<%@ page import="hotelweb.controllers.Usuario" %>
<%@ page import="hotelweb.controllers.UsuarioManager" %>
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
    <title>Registra Nueva Venta (Sistema de Ventas)</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <style>
        /* Estilos base para centrar el formulario y usar tema oscuro */
        body {
            background-color: #343a40;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Inter', sans-serif;
        }

        .form-dark-card {
            /* AUMENTO DEL ANCHO: de 800px a 1000px para evitar scroll y usar más espacio */
            max-width: 1000px; 
            width: 95%; /* Usar un 95% del ancho de la pantalla */
            background-color: #212529; /* Dark background */
            border-radius: 1rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5);
            color: #f8f9fa;
        }

        .card-header {
            background-color: #212529; /* Primary blue header for visibility */
            border-top-left-radius: 1rem;
            border-top-right-radius: 1rem;
            color: white;
            padding: 1rem 0;
        }
        
        .form-control, .form-select {
            background-color: #495057; 
            color: #fff; 
            border: 1px solid #6c757d;
            border-radius: 0.5rem;
        }

        .form-control:focus, .form-select:focus {
            background-color: #495057;
            color: #fff;
            border-color: #0d6efd; 
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        
        .form-label {
            font-weight: bold;
            color: #adb5bd;
        }
        
        /* BOTONES: Aseguramos un ancho mínimo para que sean legibles */
        .btn-responsive {
            flex-grow: 1; /* Permite que los botones crezcan y ocupen el espacio disponible */
            max-width: 150px;
        }

        .read-only-field {
            background-color: #343a40 !important; /* Más oscuro para indicar que es de solo lectura */
            border-color: #495057 !important;
            color: #fff !important;
        }
        
        /* Estilos para el título de la sección de totales */
        .section-title {
            color: #0d6efd;
            border-bottom: 2px solid white;
            padding-bottom: 0.5rem;
            margin-top: 1rem;
            margin-bottom: 1rem;
            font-size: 1.25rem;
            font-weight: 600;
        }
    </style>
</head>
<body>
    
    <div class="card form-dark-card">
        
         <div class="card-header bg-black text-center py-3 rounded-top-3">
            <h2 class="mb-0">Nueva Venta</h2>
        </div>
        
        <div class="card-body">
            <form id="ventaForm" action="VentaServlet" method="post">
                <input type="hidden" name="id" value="0"> <!-- ID de Venta, lo gestiona el backend -->
                
                <div class="row g-4">
                    
                    <!-- Columna Izquierda: Datos del Cliente, Producto y Pago (Ocupa más espacio en pantallas grandes) -->
                    <div class="col-lg-8">
                        
                        <div class="section-title text-white">Datos del Cliente</div>

                        <div class="row g-3 mb-4">
                            <!-- Cédula del Cliente -->
                            <div class="col-md-6">
                                <label for="cedulaCliente" class="form-label text-white">Cédula del Cliente:</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="cedulaCliente" name="cedulaCliente" required>
                                    <button class="btn btn-primary" type="button" id="btnBuscarCliente" onclick="buscarCliente()">Buscar Cliente</button>
                                </div>
                            </div>
                            
                            <!-- Nombre del Cliente (Sólo lectura) -->
                            <div class="col-md-6">
                                <label for="nombreCliente" class="form-label text-white">Nombre del Cliente:</label>
                                <input type="text" class="form-control read-only-field" id="nombreCliente" value="Pendiente de búsqueda" readonly>
                            </div>
                        </div>

                        <div class="section-title text-white">Detalle del Producto</div>

                        <div class="row g-3 mb-4">
                            <!-- ID/Código del Producto -->
                            <div class="col-md-6">
                                <label for="codigoProducto" class="form-label text-white">Código del Producto:</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="codigoProducto" name="codigoProducto" required>
                                    <button class="btn btn-primary" type="button" id="btnBuscarProducto" onclick="buscarProducto()">Buscar Producto</button>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="cantidad" class="form-label text-white">Cantidad:</label>
                                <input type="number" class="form-control" id="cantidad" name="cantidad" value="1" min="1" required onchange="calcularTotales()">
                            </div>

                            <div class="col-md-6">
                                <label for="descripcion" class="form-label text-white">Descripción:</label>
                                <input type="text" class="form-control read-only-field" id="descripcion" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="precioVenta" class="form-label text-white">Precio Unitario:</label>
                                <input type="text" class="form-control read-only-field" id="precioVenta" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="ivaProducto" class="form-label text-white">Tasa IVA Aplicada:</label>
                                <input type="text" class="form-control read-only-field" id="ivaProducto" readonly>
                                <input type="hidden" id="ivaPorcentaje" value="0"> <!-- Almacena el % del IVA -->
                            </div>
                        </div>

                        <!-- Información de Pago -->
                        <div class="section-title text-white">Información de Pago</div>
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label for="tipoPago" class="form-label">Tipo de Pago:</label>
                                <select class="form-select" id="tipoPago" name="tipoPago" required>
                                    <option value="" selected disabled>Seleccione...</option>
                                    <option value="EFECTIVO">Efectivo</option>
                                    <option value="TARJETA">Tarjeta</option>
                                    <option value="TRANSFERENCIA">Transferencia</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="fecha" class="form-label text-white">Fecha (Automática):</label>
                                <input type="text" class="form-control read-only-field" id="fecha" value="Fecha/Hora de Registro" readonly>
                            </div>
                        </div>

                        <!-- BOTONES AHORA EN FILA ABAJO DE LOS CAMPOS PRINCIPALES -->
                        <div class="section-title text-white">Acciones</div>
                        <div class="d-flex justify-content-center gap-3 mb-4 flex-wrap">
                            <button type="submit" name="accion" value="guardar" class="btn btn-primary btn-responsive" id="btnRegistrarVenta" disabled>Registrar</button>
                            <button type="button" name="accion" value="consultar" class="btn btn-secondary btn-responsive">Consultar</button>
                            <button type="button" name="accion" value="limpiar" class="btn btn-secondary btn-responsive" onclick="window.location.reload();">Nuevo</button>
                            <button type="button" onclick="window.location.href='Menu.jsp';" class="btn btn-info btn-responsive">Regresar</button>
                        </div>
                    </div> <!-- Fin Columna Izquierda -->

                    <!-- Columna Derecha: Totales (Mantiene su posición para destacar los valores) -->
                    <div class="col-lg-4">
                        <div class="section-title text-center text-white">Totales de Venta</div>
                        
                        <div class="d-grid gap-2 mb-4">
                            <label for="total" class="form-label">Total Venta:</label>
                            <input type="text" class="form-control read-only-field text-center fs-3 py-3" id="total" name="total" value="0.00" readonly>
                            
                            <label for="subtotal" class="form-label mt-3">Subtotal Base:</label>
                            <input type="text" class="form-control read-only-field text-center" id="subtotal" value="0.00" readonly>
                            
                            <label for="ivaTotal" class="form-label mt-2">Valor Total IVA:</label>
                            <input type="text" class="form-control read-only-field text-center" id="ivaTotal" value="0.00" readonly>
                            
                            <!-- Campos ocultos para enviar los valores correctos al backend según tu estructura de tabla -->
                            <input type="hidden" name="iva5" id="iva5" value="0.00">
                            <input type="hidden" name="iva19" id="iva19" value="0.00">
                            <input type="hidden" name="exento" id="exento" value="0.00">
                        </div>
                    </div> <!-- Fin Columna Derecha -->
                </div>
            </form>
        </div>
    </div>
    
 
</body>
</html>