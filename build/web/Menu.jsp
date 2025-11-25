<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.dao.UsuarioManager" %>
<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

    if (usuarioLogueado == null) {
        response.sendRedirect("index.jsp?error=sesion_expirada");
        return;
    }

    String paginaActual = request.getRequestURI().substring(request.getContextPath().length() + 1);

    if (!UsuarioManager.tieneAccesoPagina(usuarioLogueado, paginaActual)) {
        response.sendRedirect("Menu.jsp?error=acceso_denegado");
        return;
    }
    
    // Variables para verificar permisos
    boolean esAdministrador = usuarioLogueado.getRol().equals("Administrador");
    boolean esRecepcionista = usuarioLogueado.getRol().equals("Recepcion");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestión Hotelera - Inicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #343a40;
            color: #f8f9fa;
        }
        
        .navbar-nav .nav-link,
        .navbar-brand {
            padding-top: 1.00rem !important;
            padding-bottom: 1.50rem !important;
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

        /* ESTILOS DEL CARRUSEL DE TARJETAS */
        .carrusel-container {
            padding: 40px 20px;
            min-height: calc(100vh - 100px);
            background: linear-gradient(135deg, #343a40 0%, #1f2329 100%);
            position: relative;
            overflow: hidden;
        }

        /* Patrón de fondo sutil */
        .carrusel-container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: 
                radial-gradient(circle at 20% 50%, rgba(13, 110, 253, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(13, 202, 240, 0.05) 0%, transparent 50%);
            pointer-events: none;
        }

        .tarjetas-carrusel {
            display: flex;
            gap: 25px;
            overflow-x: auto;
            scroll-behavior: smooth;
            padding: 20px 5px;
            scrollbar-width: none;
            position: relative;
            z-index: 1;
        }

        .tarjetas-carrusel::-webkit-scrollbar {
            display: none;
        }

        .tarjeta {
            flex: 0 0 320px;
            height: 240px;
            background: linear-gradient(135deg, #495057 0%, #212529 100%);
            border: 2px solid #0d6efd;
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
            text-decoration: none;
            color: #f8f9fa;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        /* Efecto de brillo en hover */
        .tarjeta::before {
            content: "";
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                45deg,
                transparent,
                rgba(255, 255, 255, 0.1),
                transparent
            );
            transform: rotate(45deg);
            transition: all 0.6s;
        }

        .tarjeta:hover::before {
            left: 100%;
        }

        .tarjeta:hover {
            transform: translateY(-15px) scale(1.05);
            box-shadow: 0 20px 40px rgba(13, 110, 253, 0.5);
            border-color: #0dcaf0;
            background: linear-gradient(135deg, #0d6efd 0%, #0dcaf0 100%);
        }

        /* Contenedor de icono con imagen de fondo */
        .tarjeta-icono {
            width: 80px;
            height: 80px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(13, 110, 253, 0.2);
            border-radius: 50%;
            transition: all 0.4s;
            position: relative;
            z-index: 2;
        }

        .tarjeta:hover .tarjeta-icono {
            background: rgba(255, 255, 255, 0.2);
            transform: rotateY(360deg);
        }

        .tarjeta-icono i {
            font-size: 40px;
            color: #0dcaf0;
            transition: all 0.4s;
        }

        .tarjeta:hover .tarjeta-icono i {
            color: #ffffff;
            transform: scale(1.2);
        }

        .tarjeta-titulo {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #f8f9fa;
            position: relative;
            z-index: 2;
        }

        .tarjeta-descripcion {
            font-size: 14px;
            color: #adb5bd;
            position: relative;
            z-index: 2;
            line-height: 1.5;
        }

        .tarjeta:hover .tarjeta-descripcion {
            color: #f8f9fa;
        }

        /* Botones de scroll mejorados */
        .btn-scroll {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: linear-gradient(135deg, #0d6efd, #0dcaf0);
            border: none;
            color: white;
            width: 55px;
            height: 55px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 22px;
            z-index: 10;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(13, 110, 253, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-scroll:hover {
            background: linear-gradient(135deg, #0dcaf0, #0d6efd);
            transform: translateY(-50%) scale(1.15);
            box-shadow: 0 8px 25px rgba(13, 202, 240, 0.6);
        }

        .btn-scroll:active {
            transform: translateY(-50%) scale(0.95);
        }

        .btn-scroll-izq {
            left: 15px;
        }

        .btn-scroll-der {
            right: 15px;
        }

        .carrusel-wrapper {
            position: relative;
            max-width: 1400px;
            margin: 0 auto;
        }

        .titulo-seccion {
            text-align: center;
            font-size: 38px;
            font-weight: bold;
            margin-bottom: 40px;
            color: #ffffff;
            text-shadow: 0 2px 10px rgba(255, 255, 255, 0.3);
            position: relative;
            z-index: 1;
        }

        .subtitulo-seccion {
            text-align: center;
            font-size: 16px;
            color: #adb5bd;
            margin-bottom: 40px;
            position: relative;
            z-index: 1;
        }

        /* Badge de usuario */
        .usuario-badge {
            background: linear-gradient(135deg, #0d6efd, #0dcaf0);
            padding: 8px 20px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            box-shadow: 0 2px 10px rgba(13, 110, 253, 0.3);
        }

        /* Badge de rol */
        .rol-badge {
            background: linear-gradient(135deg, #198754, #20c997);
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            margin-left: 10px;
            box-shadow: 0 2px 8px rgba(25, 135, 84, 0.3);
        }

        /* Animación de entrada */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .tarjeta {
            animation: fadeInUp 0.6s ease-out backwards;
        }

        .tarjeta:nth-child(1) { animation-delay: 0.1s; }
        .tarjeta:nth-child(2) { animation-delay: 0.2s; }
        .tarjeta:nth-child(3) { animation-delay: 0.3s; }
        .tarjeta:nth-child(4) { animation-delay: 0.4s; }
        .tarjeta:nth-child(5) { animation-delay: 0.5s; }
        .tarjeta:nth-child(6) { animation-delay: 0.6s; }
        .tarjeta:nth-child(7) { animation-delay: 0.7s; }
        .tarjeta:nth-child(8) { animation-delay: 0.8s; }

        /* Marca de agua */
        .watermark {
            position: fixed;
            bottom: 20px;
            right: 30px;
            background: rgba(13, 110, 253, 0.1);
            backdrop-filter: blur(10px);
            padding: 12px 24px;
            border-radius: 30px;
            font-size: 13px;
            color: #adb5bd;
            border: 1px solid rgba(13, 110, 253, 0.3);
            z-index: 100;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .watermark:hover {
            background: rgba(13, 110, 253, 0.2);
            color: #0dcaf0;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(13, 110, 253, 0.3);
        }

        .watermark i {
            color: #0d6efd;
            margin-right: 8px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .titulo-seccion {
                font-size: 28px;
            }
            
            .tarjeta {
                flex: 0 0 280px;
                height: 220px;
            }
            
            .btn-scroll {
                width: 45px;
                height: 45px;
                font-size: 18px;
            }

            .watermark {
                bottom: 15px;
                right: 15px;
                font-size: 11px;
                padding: 10px 18px;
            }
        }
    </style>
</head>
<body>

    <!-- BARRA DE NAVEGACIÓN -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand text-white fw-bold">
                <i class="fas fa-hotel me-2 text-primary"></i>GESTIÓN HOTEL
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="navbarDropdownArchivo" role="button" data-bs-toggle="dropdown" aria-expanded="false" aria-current="page">
                            Archivo
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownArchivo">
                          <li><a class="dropdown-item text-danger" href="LogoutServlet"><i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión</a></li>
                            <li><hr class="dropdown-divider"></li>
                        </ul>
                    </li>
                    
                    <!-- Cliente - Visible para todos -->
                    <li class="nav-item">
                        <a class="nav-link text-white" href="NuevoCliente.jsp">Cliente</a>
                    </li>

                    <!-- Reservas - Visible para todos -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdownReservas" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Reservas
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownReservas">
                            <li><a class="dropdown-item" href="NuevaReserva.jsp">Reservar</a></li>
                            <li><a class="dropdown-item" href="ConsultarServlet">Consultar Reservas</a></li>
                        </ul>
                    </li>
                    
                    <!-- Check-in/out - Visible para todos -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdownCheckin" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Check-in/out
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownCheckin">
                            <li><a class="dropdown-item" href="NuevoCheckin.jsp">Nuevo Check-in</a></li>
                            <li><a class="dropdown-item" href="ConsultarCheckinServlet">Consultar Check-ins</a></li>
                        </ul>
                    </li>

                    <!-- Habitación - SOLO ADMINISTRADOR -->
                    <% if (esAdministrador) { %>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="NuevaHabitacion.jsp">Habitación</a>
                    </li>
                    <% } %>
                    
                    <!-- Productos -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdownProductos" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Productos
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownProductos">
                            <% if (esAdministrador) { %>
                            <li><a class="dropdown-item" href="RegistrarProductos.jsp">Registrar Producto</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <% } %>
                            <li><a class="dropdown-item" href="NuevaVenta.jsp">Ventas</a></li>
                            <li><a class="dropdown-item" href="ConsultarVentas.jsp">Consultar Ventas</a></li>
                        </ul>
                    </li>

                    <!-- Reportes - SOLO ADMINISTRADOR -->
                    <% if (esAdministrador) { %>
                    <li class="nav-item">
                        <a class="nav-link text-warning" href="ReportesServlet">Reportes</a>
                    </li>
                    <% } %>
                </ul>
                
                <!-- Badge de usuario y rol -->
                <div class="d-flex align-items-center">
                    <div class="usuario-badge">
                        <i class="fas fa-user-circle me-2"></i>
                        <%= usuarioLogueado.getNombreCompleto() %>
                    </div>
                    <div class="rol-badge">
                        <i class="fas fa-shield-alt me-1"></i>
                        <%= usuarioLogueado.getRol() %>
                    </div>
                </div>
            </div>
        </div>
    </nav>
    
    <!-- CONTENEDOR PRINCIPAL -->
    <div class="carrusel-container">
        <div class="titulo-seccion">
            <i class="fas fa-star me-3"></i>Bienvenido al Sistema de Gestión<i class="fas fa-star ms-3"></i>
        </div>
        <div class="subtitulo-seccion">
            Selecciona una opción para comenzar - Rol: <%= usuarioLogueado.getRol() %>
        </div>

        <div class="carrusel-wrapper">
            <!-- Botón Izquierdo -->
            <button class="btn-scroll btn-scroll-izq" onclick="scrollIzquierda()">
                <i class="fas fa-chevron-left"></i>
            </button>

            <!-- Carrusel de Tarjetas -->
            <div class="tarjetas-carrusel" id="carruselTarjetas">
                
                <!-- Tarjeta Habitaciones - SOLO ADMINISTRADOR -->
                <% if (esAdministrador) { %>
                <a href="NuevaHabitacion.jsp" class="tarjeta">
                    <div class="tarjeta-icono">
                        <i class="fas fa-bed"></i>
                    </div>
                    <div class="tarjeta-titulo">Habitaciones</div>
                    <div class="tarjeta-descripcion">Gestiona y administra habitaciones de lujo para tus huéspedes</div>
                </a>
                <% } %>

                <!-- Tarjeta Ventas - Todos -->
                <a href="NuevaVenta.jsp" class="tarjeta">
                    <div class="tarjeta-icono">
                        <i class="fas fa-cash-register"></i>
                    </div>
                    <div class="tarjeta-titulo">Nueva Venta</div>
                    <div class="tarjeta-descripcion">Registra ventas de productos y servicios del hotel</div>
                </a>

                <!-- Tarjeta Consultar Ventas - Todos -->
                <a href="ConsultarVentas.jsp" class="tarjeta">
                    <div class="tarjeta-icono">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="tarjeta-titulo">Consultar Ventas</div>
                    <div class="tarjeta-descripcion">Visualiza y analiza todas las ventas realizadas</div>
                </a>

                <!-- Tarjeta Clientes - Todos -->
                <a href="NuevoCliente.jsp" class="tarjeta">
                    <div class="tarjeta-icono">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="tarjeta-titulo">Clientes</div>
                    <div class="tarjeta-descripcion">Gestiona información y perfiles de clientes</div>
                </a>

                <!-- Tarjeta Reservas - Todos -->
                <a href="NuevaReserva.jsp" class="tarjeta">
                    <div class="tarjeta-icono">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="tarjeta-titulo">Reservas</div>
                    <div class="tarjeta-descripcion">Crea y administra nuevas reservas de habitaciones</div>
                </a>

                <!-- Tarjeta Check-in - Todos -->
                <a href="NuevoCheckin.jsp" class="tarjeta">
                    <div class="tarjeta-icono">
                        <i class="fas fa-door-open"></i>
                    </div>
                    <div class="tarjeta-titulo">Check-in</div>
                    <div class="tarjeta-descripcion">Registra la entrada de huéspedes al hotel</div>
                </a>

                <!-- Tarjeta Productos - SOLO ADMINISTRADOR -->
                <% if (esAdministrador) { %>
                <a href="RegistrarProductos.jsp" class="tarjeta">
                    <div class="tarjeta-icono">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="tarjeta-titulo">Productos</div>
                    <div class="tarjeta-descripcion">Registra y actualiza el inventario de productos</div>
                </a>
                <% } %>

                <!-- Tarjeta Reportes - SOLO ADMINISTRADOR -->
                <% if (esAdministrador) { %>
                <a href="ReportesServlet" class="tarjeta">
                    <div class="tarjeta-icono">
                        <i class="fas fa-file-chart-line"></i>
                    </div>
                    <div class="tarjeta-titulo">Reportes</div>
                    <div class="tarjeta-descripcion">Visualiza reportes y estadísticas del sistema</div>
                </a>
                <% } %>

            </div>

            <!-- Botón Derecho -->
            <button class="btn-scroll btn-scroll-der" onclick="scrollDerecha()">
                <i class="fas fa-chevron-right"></i>
            </button>
        </div>
    </div>

    <!-- Marca de agua -->
    <div class="watermark">
        <i class="fas fa-code"></i>By Melanny G & Camilo R
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        const carrusel = document.getElementById('carruselTarjetas');

        function scrollIzquierda() {
            carrusel.scrollBy({
                left: -370,
                behavior: 'smooth'
            });
        }

        function scrollDerecha() {
            carrusel.scrollBy({
                left: 370,
                behavior: 'smooth'
            });
        }

        // Scroll con rueda del mouse
        carrusel.addEventListener('wheel', (e) => {
            e.preventDefault();
            carrusel.scrollBy({
                left: e.deltaY > 0 ? 120 : -120,
                behavior: 'smooth'
            });
        });

        // Auto-scroll suave al inicio
        window.addEventListener('load', () => {
            carrusel.scrollTo({
                left: 0,
                behavior: 'smooth'
            });
        });
    </script>
</body>
</html>