<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestión Hotelera - Inicio</title>
    <!-- Enlace a Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Estilos generales para el modo oscuro */
        body {
            background-color: #212529; /* Gris oscuro de fondo */
            color: #f8f9fa; /* Color de texto blanco/claro */
        }

        /* Estilos de Navbar y Dropdown para modo oscuro */
        .navbar {
            box-shadow: 0 2px 5px rgba(0,0,0,.5);
        }
        .dropdown-menu {
            background-color: #343a40; /* Fondo del menú desplegable más oscuro */
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .dropdown-item {
            color: #f8f9fa; /* Texto claro en el menú */
        }
        .dropdown-item:hover {
            background-color: #0d6efd; /* Azul primario de Bootstrap en hover */
            color: #ffffff;
        }
        .dropdown-divider {
            border-top: 1px solid rgba(255, 255, 255, 0.15); /* Separador sutil */
        }

        /* Estilo del Carrusel */
        .carrusel-container {
            padding: 20px;
            /* Calcula la altura total de la vista menos la altura de la navbar para centrar bien */
            min-height: calc(100vh - 56px); 
            display: flex;
            align-items: center; /* Centrar verticalmente */
            justify-content: center; /* Centrar horizontalmente */
            background-color: #212529; 
        }
        
        .carrusel-bordeado {
            max-width: 1000px; /* Ancho máximo para el carrusel en escritorio */
            box-shadow: 0 0 20px rgba(0, 123, 255, 0.5); /* Sombra azul para destacar en dark mode */
            border: 3px solid #0d6efd; /* Borde de color primario */
            overflow: hidden;
        }

        .carousel-item img {
            height: 500px; 
            object-fit: cover; 
        }

        .carousel-caption {
            background: rgba(0, 0, 0, 0.6); 
            border-radius: 5px;
            padding: 10px;
        }
    </style>
</head>
<body>

    <!-- BARRA DE NAVEGACIÓN (NAVBAR) - COMPLETA Y DARK MODE -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <!-- Título de la Aplicación -->
            <a class="navbar-brand text-primary fw-bold" href="Bienvenida.html">GESTIÓN HOTEL</a>
            
            <!-- Botón de Menú Móvil (Toggler) -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    
                    <!-- Dropdown Archivo (Dashboard y Cerrar Sesión) -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="navbarDropdownArchivo" role="button" data-bs-toggle="dropdown" aria-expanded="false" aria-current="page">
                            Archivo
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownArchivo">
                            <li><a class="dropdown-item" href="index.jsp">Dashboard Principal</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="Logout.jsp">Cerrar Sesión</a></li>
                        </ul>
                    </li>
                    
                    <!-- Cliente -->
                    <li class="nav-item">
                        <a class="nav-link" href="NuevoCliente.jsp">Cliente</a>
                    </li>

                    <!-- Dropdown Reservas -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownReservas" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Reservas
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownReservas">
                            <li><a class="dropdown-item" href="NuevaReserva.jsp">Reservar</a></li>
                            <li><a class="dropdown-item" href="ConsultarReserva.jsp">Consultar Reservas</a></li>
                        </ul>
                    </li>
                    
                    <!-- Dropdown Check-in/out -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownCheckin" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Check-in/out
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownCheckin">
                            <li><a class="dropdown-item" href="NuevoCheckin.jsp">Nuevo Check-in</a></li>
                            <li><a class="dropdown-item" href="ConsultarCheckin.jsp">Consultar Check-ins</a></li>
                        </ul>
                    </li>

                    <!-- Habitación -->
                    <li class="nav-item">
                        <a class="nav-link" href="NuevaHabitacion.jsp">Habitación</a>
                    </li>
                    
                    <!-- Dropdown Productos (Registro, Ventas y Consultas) -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownProductos" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Productos
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownProductos">
                            <!-- Nueva opción agregada -->
                            <li><a class="dropdown-item" href="RegistrarProducto.jsp">Registrar Producto</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="NuevaVenta.jsp">Ventas</a></li>
                            <li><a class="dropdown-item" href="ConsultarVentas.jsp">Consultar Ventas</a></li>
                        </ul>
                    </li>
                    <!-- Fin Dropdown Productos -->

                    <li class="nav-item">
                        <a class="nav-link" href="#">Reportes</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- CONTENEDOR DEL CARRUSEL CENTRADO -->
    <div class="container carrusel-container">

        <div id="carouselExampleIndicators" class="carousel slide w-100 rounded-3 carrusel-bordeado" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <!-- Placeholder de imagen: Habitación de Lujo -->
                    <img src="https://placehold.co/1000x500/0d6efd/ffffff?text=Habitacion+VIP" class="d-block w-100" alt="Habitación 1">
                    <div class="carousel-caption d-none d-md-block">
                        <h5 class="fw-bold">Habitaciones de Lujo</h5>
                        <p>Las mejores comodidades para su estancia.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <!-- Placeholder de imagen: Piscina -->
                    <img src="https://placehold.co/1000x500/198754/ffffff?text=Area+de+Piscina" class="d-block w-100" alt="Piscina">
                    <div class="carousel-caption d-none d-md-block">
                        <h5 class="fw-bold">Área de Piscina</h5>
                        <p>Relájese bajo el sol.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <!-- Placeholder de imagen: Restaurante -->
                    <img src="https://placehold.co/1000x500/ffc107/343a40?text=Restaurante+Gourmet" class="d-block w-100" alt="Restaurante">
                    <div class="carousel-caption d-none d-md-block">
                        <h5 class="fw-bold">Restaurante Gourmet</h5>
                        <p>Pruebe nuestra cocina de autor.</p>
                    </div>
                </div>
            </div>
            <!-- Controles Prev/Next -->
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        
    </div>

    <!-- Enlace a Bootstrap JS (necesario para el carrusel y los dropdowns) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>