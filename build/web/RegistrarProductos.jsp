<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Producto</title>
    
    <!-- Enlace a Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Iconos de Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        /* Estilos generales para el modo oscuro */
        body {
            background-color: #212529; /* Gris oscuro de fondo */
            color: #f8f9fa; /* Color de texto blanco/claro */
        }
        .navbar {
            box-shadow: 0 2px 5px rgba(0,0,0,.5);
        }
         
        .dropdown-menu {
            background-color: #343a40; 
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .dropdown-item {
            color: #f8f9fa; 
        }
        .dropdown-item:hover {
            background-color: #0d6efd; 
            color: #ffffff;
        }
        .dropdown-divider {
            border-top: 1px solid rgba(255, 255, 255, 0.15);
        }
        
        /* 1. ESTILO DE LA BARRA DE TÍTULO (Barra negra) */
        .main-title-bar {
            background-color: #1a1e22; /* Negro muy oscuro/gris para la barra de título */
            padding: 15px 20px;
            border-radius: 8px 8px 0 0; /* Bordes superiores redondeados */
            margin-bottom: 0; /* Elimina espacio antes del formulario */
            /* Propiedad para centrar el texto dentro del padding */
            text-align: center; 
        }

        /* Contenedor principal del formulario */
        .form-container {
            background-color: #212529; /* Un gris más oscuro para el fondo del formulario */
            padding: 30px;
            border-radius: 0 0 8px 8px; /* Bordes inferiores redondeados */
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
            margin-top: -1px; /* Para que se pegue perfectamente a la barra de título */
        }
        .form-section-title {
            background-color: #343a40; /* Fondo para los títulos de sección */
            color: #ffffff;
            padding: 10px 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 1.25rem; 
            font-weight: bold;
        }
        .form-label {
            color: #ced4da; 
            font-weight: 500;
        }
        .form-control, .form-select {
            background-color: #343a40; 
            color: #f8f9fa; 
            border: 1px solid #495057; 
        }
        .form-control:focus, .form-select:focus {
            background-color: #343a40;
            color: #f8f9fa;
            border-color: #0d6efd; 
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .input-group-text {
            background-color: #495057; 
            color: #f8f9fa;
            border: 1px solid #495057;
        }
        /* Estilo para los botones */
        .btn-custom {
            width: 100%;
            margin-bottom: 10px; 
            font-weight: bold;
        }
        .btn-primary { background-color: #0d6efd; border-color: #0d6efd; }
        .btn-primary:hover { background-color: #0b5ed7; border-color: #0a58ca; }
        .btn-info { background-color: #0dcaf0; border-color: #0dcaf0; }
        .btn-info:hover { background-color: #31d2f2; border-color: #25cff2; }
        .btn-danger { background-color: #dc3545; border-color: #dc3545; }
        .btn-danger:hover { background-color: #bb2d3b; border-color: #b02a37; }
        .btn-secondary { background-color: #6c757d; border-color: #6c757d; }
        .btn-secondary:hover { background-color: #5c636a; border-color: #565e64; }
    </style>
</head>
<body>

    <!-- BARRA DE NAVEGACIÓN -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand text-primary fw-bold" href="Bienvenida.html">GESTIÓN HOTEL</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownArchivo" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Archivo
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownArchivo">
                            <li><a class="dropdown-item" href="index.jsp">Dashboard Principal</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="Logout.jsp">Cerrar Sesión</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="NuevoCliente.jsp">Cliente</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownReservas" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Reservas
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownReservas">
                            <li><a class="dropdown-item" href="NuevaReserva.jsp">Reservar</a></li>
                            <li><a class="dropdown-item" href="ConsultarReserva.jsp">Consultar Reservas</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownCheckin" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Check-in/out
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownCheckin">
                            <li><a class="dropdown-item" href="NuevoCheckin.jsp">Nuevo Check-in</a></li>
                            <li><a class="dropdown-item" href="ConsultarCheckin.jsp">Consultar Check-ins</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="NuevaHabitacion.jsp">Habitación</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" aria-current="page" href="#" id="navbarDropdownProductos" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Productos
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownProductos">
                            <li><a class="dropdown-item" href="RegistrarProducto.jsp">Registrar Producto</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="NuevaVenta.jsp">Ventas</a></li>
                            <li><a class="dropdown-item" href="ConsultarVentas.jsp">Consultar Ventas</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Reportes</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENEDOR PRINCIPAL -->
    <main class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-9">
                
                <!-- BARRA DE TÍTULO (NUEVO ELEMENTO) -->
                <div class="main-title-bar">
                    <h4 class="text-white mb-0 ">REGISTRAR NUEVO PRODUCTO</h4>
                </div>

                <div class="form-container">
                    <!-- El título dentro del form-container ya no es necesario ya que usamos la barra de título exterior -->
                    <!-- <h2 class="text-center text-white mb-4">Registrar Nuevo Producto</h2> -->

                    <form action="RegistrarProductoServlet" method="post">
                        <div class="row">
                            
                            <!-- COLUMNA IZQUIERDA: DETALLES DEL PRODUCTO -->
                            <div class="col-md-7 border-end border-secondary pe-md-4">
                                <div class="form-section-title">Detalles del Producto</div>

                                <!-- Código -->
                                <div class="mb-3">
                                    <label for="codigo" class="form-label">Código:</label>
                                    <input type="text" class="form-control" id="codigo" name="codigo" required>
                                </div>

                                <!-- Descripción -->
                                <div class="mb-3">
                                    <label for="descripcion" class="form-label">Descripción:</label>
                                    <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required></textarea>
                                </div>

                                <!-- Categoría -->
                                <div class="mb-3">
                                    <label for="categoria" class="form-label">Categoría:</label>
                                    <select class="form-select" id="categoria" name="cod_categoria" required>
                                        <option selected disabled value="">Seleccione...</option>
                                        <option value="1">Alimentos</option>
                                        <option value="2">Bebidas</option>
                                        <option value="3">Higiene Personal</option>
                                        <option value="4">Limpieza</option>
                                        <option value="5">Otros</option>
                                    </select>
                                </div>

                                <!-- Fecha de Vencimiento -->
                                <div class="mb-3">
                                    <label for="vencimiento" class="form-label">Fecha de Vencimiento:</label>
                                    <div class="input-group">
                                        <input type="date" class="form-control" id="vencimiento" name="vencimiento">
                                        <span class="input-group-text"><i class="bi bi-calendar"></i></span>
                                    </div>
                                    <small class="form-text text-muted">Opcional. Dejar vacío si no aplica.</small>
                                </div>
                            </div>

                            
                            <!-- COLUMNA DERECHA: INFORMACIÓN FINANCIERA Y STOCK -->
                            <div class="col-md-5 ps-md-4">
                                <div class="form-section-title">Información Financiera y Stock</div>

                                <!-- Precio de Venta -->
                                <div class="mb-3">
                                    <label for="precioVenta" class="form-label">Precio de Venta:</label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" step="0.01" class="form-control" id="precioVenta" name="precioVenta" required>
                                    </div>
                                </div>

                                <!-- Precio de Compra -->
                                <div class="mb-3">
                                    <label for="precioCompra" class="form-label">Precio de Compra:</label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" step="0.01" class="form-control" id="precioCompra" name="precioCompra" required>
                                    </div>
                                </div>

                                <!-- IVA (%) -->
                                <div class="mb-3">
                                    <label for="iva" class="form-label">IVA (%):</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="iva" name="iva" value="0" min="0" max="100" required>
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>

                                <!-- Existencia Inicial -->
                                <div class="mb-4">
                                    <label for="existencia" class="form-label">Existencia Inicial:</label>
                                    <input type="number" class="form-control" id="existencia" name="existencia" min="0" value="0" required>
                                    <small class="form-text text-muted">Cantidad de unidades disponibles.</small>
                                </div>

                                <!-- Botones de Acción -->
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary btn-custom">Registrar Producto</button>
                                    <button type="button" class="btn btn-info btn-custom">Limpiar Formulario</button>
                                    <button type="button" class="btn btn-secondary btn-custom" onclick="window.location.href='Menu.jsp'">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <!-- Enlace a Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>