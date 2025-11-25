<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.dao.UsuarioManager" %>
<%@ page import="hotelweb.models.Checkin" %>
<%@ page import="hotelweb.dao.CheckinDAO" %>
<%@ page import="java.util.List" %>

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

    CheckinDAO dao = new CheckinDAO();
    List<Checkin> checkinsActivos = dao.listarCheckinsActivos();
    
    // DEBUG: Mostrar cuántos check-ins hay
    System.out.println("=== DEBUG: Cantidad de check-ins activos: " + (checkinsActivos != null ? checkinsActivos.size() : "NULL") + " ===");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultar Check-ins - Sistema Hotelero</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #343a40;
            color: #f8f9fa;
        }

        .navbar {
            box-shadow: 0 2px 5px rgba(0,0,0,.5);
        }

        .container-content {
            padding: 40px 20px;
            min-height: calc(100vh - 100px);
            background: linear-gradient(135deg, #343a40 0%, #1f2329 100%);
        }

        .header-section {
            background: linear-gradient(135deg, #0d6efd 0%, #0dcaf0 100%);
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(13, 110, 253, 0.3);
            text-align: center;
        }

        .header-section h1 {
            color: white;
            font-weight: bold;
            margin: 0;
            font-size: 32px;
        }

        .header-section p {
            color: rgba(255, 255, 255, 0.9);
            margin: 10px 0 0 0;
            font-size: 14px;
        }

        .table-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            overflow-x: auto;
        }

        .table {
            margin: 0;
            color: #2c3e50;
        }

        .table thead {
            background: linear-gradient(135deg, #0d6efd 0%, #0dcaf0 100%);
            color: white;
        }

        .table thead th {
            padding: 15px;
            font-weight: 600;
            border: none;
            vertical-align: middle;
        }

        .table tbody td {
            padding: 12px 15px;
            vertical-align: middle;
            border-bottom: 1px solid #ecf0f1;
        }

        .table tbody tr:hover {
            background-color: #f8f9fa;
        }

        .badge-pagado {
            background-color: #3498db;
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
        }

        .badge-pendiente {
            background-color: #f39c12;
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
        }

        .btn-facturar {
            background-color: #27ae60;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-facturar:hover {
            background-color: #229954;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(39, 174, 96, 0.3);
            color: white;
        }

        .btn-checkout {
            background-color: #f39c12;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
            transition: all 0.3s;
        }

        .btn-checkout:hover {
            background-color: #e67e22;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(243, 156, 18, 0.3);
        }

        .sin-datos {
            text-align: center;
            padding: 40px;
            color: #7f8c8d;
        }

        .sin-datos i {
            font-size: 48px;
            margin-bottom: 20px;
            color: #95a5a6;
        }

        .btn-regresar {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 30px;
            background-color: #95a5a6;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            transition: all 0.3s;
        }

        .btn-regresar:hover {
            background-color: #7f8c8d;
            transform: translateY(-2px);
            color: white;
        }

        .navbar-nav .nav-link,
        .navbar-brand {
            padding-top: 1.00rem;
            padding-bottom: 1.50rem;
        }

        .usuario-badge {
            background: linear-gradient(135deg, #0d6efd, #0dcaf0);
            padding: 8px 20px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
        }

        .rol-badge {
            background: linear-gradient(135deg, #198754, #20c997);
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            margin-left: 10px;
        }

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
        }

        .alert-info {
            background-color: #d1ecf1;
            border: 1px solid #bee5eb;
            color: #0c5460;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

    <!-- BARRA DE NAVEGACIÓN -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand text-white fw-bold" href="Menu.jsp">
                <i class="fas fa-hotel me-2 text-primary"></i>GESTIÓN HOTEL
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="Menu.jsp"><i class="fas fa-home me-2"></i>Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="NuevoCheckin.jsp"><i class="fas fa-plus me-2"></i>Nuevo Check-in</a>
                    </li>
                </ul>
                
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

    <!-- CONTENIDO PRINCIPAL -->
    <div class="container-content">
        <div class="container">
            <!-- ENCABEZADO -->
            <div class="header-section">
                <h1><i class="fas fa-door-open me-2"></i>Check-ins Activos</h1>
                <p>Gestiona y factura a tus huéspedes</p>
            </div>

            <!-- ALERTA DE DEBUG -->
            <div class="alert-info">
                <i class="fas fa-info-circle me-2"></i>
                <strong>Total de Check-ins Activos:</strong> 
                <%= checkinsActivos != null ? checkinsActivos.size() : 0 %>
            </div>

            <!-- TABLA DE CHECK-INS -->
            <% if (checkinsActivos != null && !checkinsActivos.isEmpty()) { %>
                <div class="table-container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Habitación</th>
                                <th>Cliente</th>
                                <th>Cédula</th>
                                <th>Entrada</th>
                                <th>Salida</th>
                                <th>Total</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                for (Checkin checkin : checkinsActivos) {
                                    String estadoClass = "Pagado".equals(checkin.getEstadoPago()) ? "badge-pagado" : "badge-pendiente";
                            %>
                                <tr>
                                    <td><strong>#<%= checkin.getIdCheckin() %></strong></td>
                                    <td><%= checkin.getNumHabitacion() %> - <%= checkin.getTipoHabitacion() %></td>
                                    <td><%= checkin.getClienteNombre() %> <%= checkin.getClienteApellido() %></td>
                                    <td><%= checkin.getClienteCedula() %></td>
                                    <td><%= checkin.getFechaEntrada() %></td>
                                    <td><%= checkin.getFechaSalida() %></td>
                                    <td><strong>$<%= String.format("%.2f", checkin.getCostoTotal()) %></strong></td>
                                    <td><span class="<%= estadoClass %>"><%= checkin.getEstadoPago() %></span></td>
                                    <td>
                                        <!-- BOTÓN FACTURAR -->
                                        <a href="Facturacion.jsp?idCheckin=<%= checkin.getIdCheckin() %>" class="btn-facturar">
                                            <i class="fas fa-receipt"></i> Facturar
                                        </a>

                                        <!-- BOTÓN CHECK-OUT -->
                                        <form action="CheckinServlet" method="POST" style="display:inline;">
                                            <input type="hidden" name="accion" value="finalizar_checkout">
                                            <input type="hidden" name="idCheckin" value="<%= checkin.getIdCheckin() %>">
                                            <input type="hidden" name="numHabitacion" value="<%= checkin.getNumHabitacion() %>">
                                            <button type="submit" class="btn-checkout" onclick="return confirm('¿Procesar salida del cliente?')">
                                                <i class="fas fa-sign-out-alt"></i> Check-out
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <div class="table-container">
                    <div class="sin-datos">
                        <i class="fas fa-inbox"></i>
                        <h4>No hay check-ins activos</h4>
                        <p>Necesitas crear un check-in primero</p>
                        <a href="NuevoCheckin.jsp" class="btn-regresar">
                            <i class="fas fa-plus me-2"></i>Crear Check-in
                        </a>
                    </div>
                </div>
            <% } %>

            <!-- BOTÓN REGRESAR -->
            <a href="Menu.jsp" class="btn-regresar">
                <i class="fas fa-arrow-left me-2"></i>Volver al Menú
            </a>
        </div>
    </div>

    <!-- Marca de agua -->
    <div class="watermark">
        <i class="fas fa-code"></i>By Melanny G & Camilo R
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>