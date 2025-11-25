<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.dao.UsuarioManager" %>
<%@ page import="java.util.List" %>
<%@ page import="hotelweb.models.*" %>
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
    
    // Verificar que solo administradores accedan
    if (!usuarioLogueado.getRol().equals("Administrador")) {
        response.sendRedirect("Menu.jsp?error=acceso_denegado");
        return;
    }

    // Obtener datos del request (enviados por el servlet)
    List<Cliente> listaClientes = (List<Cliente>) request.getAttribute("listaClientes");
    List<Habitacion> listaHabitaciones = (List<Habitacion>) request.getAttribute("listaHabitaciones");
    List<Reserva> listaReservas = (List<Reserva>) request.getAttribute("listaReservas");
    List<Checkin> listaCheckins = (List<Checkin>) request.getAttribute("listaCheckins");
    List<Producto> listaProductos = (List<Producto>) request.getAttribute("listaProductos");
    List<Venta> listaVentas = (List<Venta>) request.getAttribute("listaVentas");
    
    // Calcular estadísticas
    int totalClientes = (listaClientes != null) ? listaClientes.size() : 0;
    int totalHabitaciones = (listaHabitaciones != null) ? listaHabitaciones.size() : 0;
    int totalReservas = (listaReservas != null) ? listaReservas.size() : 0;
    int totalCheckins = (listaCheckins != null) ? listaCheckins.size() : 0;
    int totalProductos = (listaProductos != null) ? listaProductos.size() : 0;
    int totalVentas = (listaVentas != null) ? listaVentas.size() : 0;
    
    // Calcular ingresos totales
    double ingresosTotales = 0.0;
    if (listaVentas != null) {
        for (Venta v : listaVentas) {
            ingresosTotales += v.getTotalVenta();
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes del Sistema</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #343a40;
            min-height: 100vh;
            padding: 20px;
        }

        .container-reportes {
            max-width: 1400px;
            margin: 0 auto;
        }

        .header-reportes {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .header-reportes h1 {
            color: #1e3c72;
            font-weight: bold;
            margin: 0;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .stat-card .icon {
            font-size: 40px;
            margin-bottom: 15px;
        }

        .stat-card.clientes .icon { color: #0d6efd; }
        .stat-card.habitaciones .icon { color: #6f42c1; }
        .stat-card.reservas .icon { color: #0dcaf0; }
        .stat-card.checkins .icon { color: #198754; }
        .stat-card.productos .icon { color: #fd7e14; }
        .stat-card.ventas .icon { color: #dc3545; }
        .stat-card.ingresos .icon { color: #198754; }

        .stat-card h3 {
            font-size: 36px;
            font-weight: bold;
            margin: 10px 0;
            color: #333;
        }

        .stat-card p {
            color: #666;
            margin: 0;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .report-section {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .report-section h2 {
            color: #1e3c72;
            font-weight: bold;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 3px solid #0d6efd;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .table-responsive {
            margin-top: 15px;
        }

        .table {
            margin: 0;
        }

        .table thead {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
        }

        .table thead th {
            border: none;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.5px;
            padding: 15px 10px;
        }

        .table tbody tr {
            transition: background-color 0.2s;
        }

        .table tbody tr:hover {
            background-color: #f8f9fa;
        }

        .badge-estado {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }

        .btn-volver {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .btn-volver:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(30, 60, 114, 0.4);
            color: white;
        }

        .btn-imprimir {
            background: linear-gradient(135deg, #198754 0%, #20c997 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s;
            margin-left: 10px;
        }

        .btn-imprimir:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(25, 135, 84, 0.4);
            color: white;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #999;
            font-style: italic;
        }

        @media print {
            body {
                background: white;
            }
            .btn-volver, .btn-imprimir {
                display: none;
            }
            .report-section {
                box-shadow: none;
                page-break-inside: avoid;
            }
        }
    </style>
</head>
<body>
    <div class="container-reportes">
        <!-- Header -->
        <div class="header-reportes">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1><i class="fas fa-chart-bar me-3"></i>Reportes del Sistema</h1>
                    <p class="text-muted mb-0">Vista general de todos los datos del sistema hotelero</p>
                </div>
                <div>
                    <a href="Menu.jsp" class="btn btn-volver">
                        <i class="fas fa-arrow-left me-2"></i>Volver al Menú
                    </a>
                    <button onclick="window.print()" class="btn btn-imprimir">
                        <i class="fas fa-print me-2"></i>Imprimir
                    </button>
                </div>
            </div>
        </div>

        <!-- Estadísticas Generales -->
        <div class="stats-grid">
            <div class="stat-card clientes">
                <div class="icon"><i class="fas fa-users"></i></div>
                <h3><%= totalClientes %></h3>
                <p>Clientes</p>
            </div>
            <div class="stat-card habitaciones">
                <div class="icon"><i class="fas fa-bed"></i></div>
                <h3><%= totalHabitaciones %></h3>
                <p>Habitaciones</p>
            </div>
            <div class="stat-card reservas">
                <div class="icon"><i class="fas fa-calendar-check"></i></div>
                <h3><%= totalReservas %></h3>
                <p>Reservas</p>
            </div>
            <div class="stat-card checkins">
                <div class="icon"><i class="fas fa-door-open"></i></div>
                <h3><%= totalCheckins %></h3>
                <p>Check-ins</p>
            </div>
            <div class="stat-card productos">
                <div class="icon"><i class="fas fa-box"></i></div>
                <h3><%= totalProductos %></h3>
                <p>Productos</p>
            </div>
            <div class="stat-card ventas">
                <div class="icon"><i class="fas fa-shopping-cart"></i></div>
                <h3><%= totalVentas %></h3>
                <p>Ventas</p>
            </div>
            <div class="stat-card ingresos">
                <div class="icon"><i class="fas fa-dollar-sign"></i></div>
                <h3>$<%= String.format("%.2f", ingresosTotales) %></h3>
                <p>Ingresos Totales</p>
            </div>
        </div>

        <!-- CLIENTES -->
        <div class="report-section">
            <h2><i class="fas fa-users"></i> Clientes Registrados</h2>
            <% if (listaClientes != null && !listaClientes.isEmpty()) { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cédula</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Teléfono</th>
                            <th>Correo</th>
                            <th>Dirección</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Cliente c : listaClientes) { %>
                        <tr>
                            <td><%= c.getIdCliente() %></td>
                            <td><%= c.getCedula() %></td>
                            <td><%= c.getNombre() %></td>
                            <td><%= c.getApellido() %></td>
                            <td><%= c.getTelefono() %></td>
                            <td><%= c.getCorreo() %></td>
                            <td><%= c.getDireccion() %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="no-data">No hay clientes registrados en el sistema</div>
            <% } %>
        </div>

        <!-- HABITACIONES -->
        <div class="report-section">
            <h2><i class="fas fa-bed"></i> Habitaciones</h2>
            <% if (listaHabitaciones != null && !listaHabitaciones.isEmpty()) { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Número</th>
                            <th>Tipo</th>
                            <th>Precio</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Habitacion h : listaHabitaciones) { %>
                        <tr>
                            <td><%= h.getIdHabitacion() %></td>
                            <td><%= h.getNumero() %></td>
                            <td><%= h.getTipo() %></td>
                            <td>$<%= String.format("%.2f", h.getPrecio()) %></td>
                            <td>
                                <% if ("Disponible".equals(h.getEstado())) { %>
                                    <span class="badge-estado bg-success">Disponible</span>
                                <% } else if ("Ocupada".equals(h.getEstado())) { %>
                                    <span class="badge-estado bg-danger">Ocupada</span>
                                <% } else { %>
                                    <span class="badge-estado bg-warning">Mantenimiento</span>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="no-data">No hay habitaciones registradas en el sistema</div>
            <% } %>
        </div>

        <!-- RESERVAS -->
        <div class="report-section">
            <h2><i class="fas fa-calendar-check"></i> Reservas</h2>
            <% if (listaReservas != null && !listaReservas.isEmpty()) { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cliente</th>
                            <th>Cédula</th>
                            <th>Entrada</th>
                            <th>Salida</th>
                            <th>Tipo Hab.</th>
                            <th>Hab. Asignada</th>
                            <th>Huéspedes</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Reserva r : listaReservas) { %>
                        <tr>
                            <td><%= r.getIdReserva() %></td>
                            <td><%= r.getClienteNombre() %> <%= r.getClienteApellido() %></td>
                            <td><%= r.getCedulaCliente() %></td>
                            <td><%= r.getFechaEntrada() %> <%= r.getHoraEntrada() %></td>
                            <td><%= r.getFechaSalida() %> <%= r.getHoraSalida() %></td>
                            <td><%= r.getTipoHabitacion() %></td>
                            <td><%= r.getHabitacionAsignada() %></td>
                            <td><%= r.getNumHuespedes() %></td>
                            <td><span class="badge-estado bg-info"><%= r.getEstadoReserva() %></span></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="no-data">No hay reservas registradas en el sistema</div>
            <% } %>
        </div>

        <!-- CHECK-INS -->
        <div class="report-section">
            <h2><i class="fas fa-door-open"></i> Check-ins</h2>
            <% if (listaCheckins != null && !listaCheckins.isEmpty()) { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cliente</th>
                            <th>Cédula</th>
                            <th>Entrada</th>
                            <th>Salida</th>
                            <th>Habitación</th>
                            <th>Tipo</th>
                            <th>Costo Total</th>
                            <th>Estado Pago</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Checkin ch : listaCheckins) { %>
                        <tr>
                            <td><%= ch.getIdCheckin() %></td>
                            <td><%= ch.getClienteNombre() %> <%= ch.getClienteApellido() %></td>
                            <td><%= ch.getClienteCedula() %></td>
                            <td><%= ch.getFechaEntrada() %> <%= ch.getHoraEntrada() %></td>
                            <td><%= ch.getFechaSalida() %> <%= ch.getHoraSalida() %></td>
                            <td><%= ch.getNumHabitacion() %></td>
                            <td><%= ch.getTipoHabitacion() %></td>
                            <td>$<%= String.format("%.2f", ch.getCostoTotal()) %></td>
                            <td>
                                <% if ("Pagado".equals(ch.getEstadoPago())) { %>
                                    <span class="badge-estado bg-success">Pagado</span>
                                <% } else { %>
                                    <span class="badge-estado bg-warning">Pendiente</span>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="no-data">No hay check-ins registrados en el sistema</div>
            <% } %>
        </div>

        <!-- PRODUCTOS -->
        <div class="report-section">
            <h2><i class="fas fa-box"></i> Productos</h2>
            <% if (listaProductos != null && !listaProductos.isEmpty()) { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Código</th>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>Precio</th>
                            <th>IVA %</th>
                            <th>Existencia</th>
                            <th>Vencimiento</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Producto p : listaProductos) { %>
                        <tr>
                            <td><%= p.getIdProducto() %></td>
                            <td><%= p.getCodigo() %></td>
                            <td><%= p.getNombre() %></td>
                            <td><%= p.getDescripcion() %></td>
                            <td>$<%= String.format("%.2f", p.getPrecio()) %></td>
                            <td><%= String.format("%.0f", p.getImpuesto()) %>%</td>
                            <td><%= p.getExistencia() %></td>
                            <td><%= p.getFechaVencimiento() != null ? p.getFechaVencimiento() : "N/A" %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="no-data">No hay productos registrados en el sistema</div>
            <% } %>
        </div>

        <!-- VENTAS -->
        <div class="report-section">
            <h2><i class="fas fa-shopping-cart"></i> Ventas</h2>
            <% if (listaVentas != null && !listaVentas.isEmpty()) { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Factura</th>
                            <th>Fecha</th>
                            <th>Hora</th>
                            <th>Cliente</th>
                            <th>Cédula</th>
                            <th>Método Pago</th>
                            <th>Subtotal</th>
                            <th>IVA</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Venta v : listaVentas) { %>
                        <tr>
                            <td><%= v.getIdVenta() %></td>
                            <td><%= v.getNumeroFactura() %></td>
                            <td><%= v.getFecha() %></td>
                            <td><%= v.getHora() %></td>
                            <td><%= v.getNombreCliente() %></td>
                            <td><%= v.getCedulaCliente() %></td>
                            <td><%= v.getMetodoPago() %></td>
                            <td>$<%= String.format("%.2f", v.getSubtotal()) %></td>
                            <td>$<%= String.format("%.2f", v.getIvaTotal()) %></td>
                            <td><strong>$<%= String.format("%.2f", v.getTotalVenta()) %></strong></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="no-data">No hay ventas registradas en el sistema</div>
            <% } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>