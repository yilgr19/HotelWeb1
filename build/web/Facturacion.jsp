<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.dao.UsuarioManager" %>
<%@ page import="hotelweb.models.Venta" %>
<%@ page import="hotelweb.dao.VentaDAO" %>
<%@ page import="hotelweb.models.Checkin" %>
<%@ page import="hotelweb.dao.CheckinDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    // --- GUARDIÁN DE SESIÓN Y ROLES ---
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
    // --- FIN DEL GUARDIÁN ---

    // Obtener datos del check-in
    CheckinDAO checkinDao = new CheckinDAO();
    String idCheckinStr = request.getParameter("idCheckin");
    Checkin checkin = null;
    List<Object[]> ventasCliente = null;
    double costoHabitacion = 0;
    double subtotalProductos = 0;
    double ivaProductos = 0;
    double totalProductos = 0;
    double totalGeneral = 0;

    if (idCheckinStr != null && !idCheckinStr.isEmpty()) {
        try {
            int idCheckin = Integer.parseInt(idCheckinStr);
            checkin = checkinDao.obtenerCheckinPorId(idCheckin);
            
            if (checkin != null) {
                // Calcular costo de habitación
                costoHabitacion = checkin.getCostoTotal();
                
                // Obtener ventas del cliente (productos del minibar)
                VentaDAO ventaDao = new VentaDAO();
                ventasCliente = ventaDao.obtenerVentasPorCliente(checkin.getClienteCedula());
                
                // Calcular totales de productos
                if (ventasCliente != null && !ventasCliente.isEmpty()) {
                    for (Object[] venta : ventasCliente) {
                        double total = (Double) venta[6]; // total_venta está en índice 6
                        double subtotal = (Double) venta[7]; // subtotal en índice 7
                        double iva = (Double) venta[8]; // iva en índice 8
                        
                        totalProductos += total;
                        subtotalProductos += subtotal;
                        ivaProductos += iva;
                    }
                }
                
                // Calcular total general
                totalGeneral = costoHabitacion + totalProductos;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Facturación - Sistema Hotelero</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #343a40;
            min-height: 100vh;
            padding: 20px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container-factura {
            max-width: 900px;
            margin: 0 auto;
        }

        .factura-header {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 30px;
            border-radius: 10px 10px 0 0;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .factura-header h1 {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .factura-header p {
            font-size: 14px;
            opacity: 0.9;
        }

        .factura-content {
            background: white;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .section-title {
            background-color: #ecf0f1;
            padding: 12px 20px;
            margin-top: 20px;
            margin-bottom: 15px;
            border-left: 4px solid #3498db;
            font-weight: bold;
            color: #2c3e50;
            border-radius: 4px;
        }

        .section-title:first-of-type {
            margin-top: 0;
        }

        .info-cliente {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }

        .info-item {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-weight: bold;
            color: #2c3e50;
            font-size: 12px;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .info-value {
            color: #34495e;
            font-size: 15px;
        }

        .table-custom {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .table-custom thead {
            background-color: #3498db;
            color: white;
        }

        .table-custom th {
            padding: 12px;
            text-align: left;
            font-weight: 600;
            border: none;
        }

        .table-custom td {
            padding: 12px;
            border-bottom: 1px solid #ecf0f1;
        }

        .table-custom tbody tr:hover {
            background-color: #f8f9fa;
        }

        .table-custom tbody tr:last-child td {
            border-bottom: 2px solid #3498db;
        }

        .text-right {
            text-align: right;
        }

        .text-center {
            text-align: center;
        }

        .resumen-costos {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
        }

        .resumen-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            font-size: 15px;
            border-bottom: 1px solid #ecf0f1;
        }

        .resumen-row.total {
            font-size: 18px;
            font-weight: bold;
            background-color: white;
            padding: 15px;
            border: 2px solid #27ae60;
            border-radius: 4px;
            margin-top: 10px;
            color: #27ae60;
        }

        .resumen-row label {
            margin: 0;
            font-weight: 500;
        }

        .resumen-row .valor {
            font-weight: bold;
            color: #2c3e50;
        }

        .resumen-row.total .valor {
            color: #27ae60;
            font-size: 20px;
        }

        .monto-grande {
            font-size: 24px;
            color: #27ae60;
            font-weight: bold;
        }

        .btn-group-custom {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 25px;
        }

        .btn-custom {
            padding: 12px 30px;
            font-size: 15px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-cobrar {
            background-color: #27ae60;
            color: white;
        }

        .btn-cobrar:hover {
            background-color: #229954;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(39, 174, 96, 0.3);
        }

        .btn-regresar {
            background-color: #95a5a6;
            color: white;
        }

        .btn-regresar:hover {
            background-color: #7f8c8d;
            transform: translateY(-2px);
        }

        .btn-imprimir {
            background-color: #3498db;
            color: white;
        }

        .btn-imprimir:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }

        .sin-datos {
            text-align: center;
            padding: 20px;
            color: #7f8c8d;
            font-size: 16px;
        }

        .alerta-error {
            background-color: #ffe6e6;
            border: 1px solid #ff4444;
            color: #c00;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .factura-footer {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 20px;
            border-radius: 0 0 10px 10px;
            text-align: center;
            font-size: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        @media print {
            body {
                background: white;
                padding: 0;
            }
            .btn-group-custom {
                display: none;
            }
            .factura-header, .factura-content, .factura-footer {
                box-shadow: none;
            }
        }
    </style>
</head>
<body>
    <div class="container-factura">
        
        <!-- ENCABEZADO -->
        <div class="factura-header">
            <h1><i class="fas fa-receipt"></i> FACTURA DE COBRO</h1>
            <p>Sistema de Gestión Hotelera</p>
        </div>

        <!-- CONTENIDO -->
        <div class="factura-content">

            <% if (checkin == null) { %>
                <div class="alerta-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <strong>Error:</strong> No se encontraron datos del check-in. Por favor, selecciona un check-in válido.
                </div>
                <div class="sin-datos">
                    <a href="ConsultarCheckinServlet" class="btn btn-regresar"><i class="fas fa-arrow-left"></i> Volver</a>
                </div>
            <% } else { %>

                <!-- INFORMACIÓN DEL CLIENTE -->
                <div class="section-title">
                    <i class="fas fa-user-circle"></i> Información del Cliente
                </div>
                <div class="info-cliente">
                    <div class="info-item">
                        <span class="info-label">Nombre Completo</span>
                        <span class="info-value"><%= checkin.getClienteNombre() %> <%= checkin.getClienteApellido() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Cédula</span>
                        <span class="info-value"><%= checkin.getClienteCedula() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Teléfono</span>
                        <span class="info-value"><%= checkin.getClienteTelefono() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Habitación</span>
                        <span class="info-value"><%= checkin.getNumHabitacion() %> - <%= checkin.getTipoHabitacion() %></span>
                    </div>
                </div>

                <!-- ESTADÍA -->
                <div class="section-title">
                    <i class="fas fa-calendar-alt"></i> Período de Estadía
                </div>
                <div class="info-cliente">
                    <div class="info-item">
                        <span class="info-label">Fecha de Entrada</span>
                        <span class="info-value"><%= checkin.getFechaEntrada() %> a las <%= checkin.getHoraEntrada() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Fecha de Salida</span>
                        <span class="info-value"><%= checkin.getFechaSalida() %> a las <%= checkin.getHoraSalida() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Tiempo de Estadía</span>
                        <span class="info-value"><%= checkin.getTiempoEstadia() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Precio por Noche</span>
                        <span class="info-value">$<%= String.format("%.2f", checkin.getPrecioNoche()) %></span>
                    </div>
                </div>

                <!-- DESGLOSE DE COSTOS - HABITACIÓN -->
                <div class="section-title">
                    <i class="fas fa-bed"></i> Costo de Habitación
                </div>
                <table class="table-custom">
                    <thead>
                        <tr>
                            <th>Descripción</th>
                            <th class="text-right">Días</th>
                            <th class="text-right">Precio/Día</th>
                            <th class="text-right">Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><%= checkin.getTipoHabitacion() %> - Habitación <%= checkin.getNumHabitacion() %></td>
                            <td class="text-right"><%= checkin.getTiempoEstadia() %></td>
                            <td class="text-right">$<%= String.format("%.2f", checkin.getPrecioNoche()) %></td>
                            <td class="text-right"><strong>$<%= String.format("%.2f", costoHabitacion) %></strong></td>
                        </tr>
                    </tbody>
                </table>

                <!-- DESGLOSE DE COSTOS - MINIBAR (VENTAS) -->
                <div class="section-title">
                    <i class="fas fa-shopping-cart"></i> Consumos Minibar
                </div>

                <% if (ventasCliente == null || ventasCliente.isEmpty()) { %>
                    <div class="sin-datos">
                        <i class="fas fa-info-circle"></i> Sin consumos registrados en el minibar
                    </div>
                <% } else { %>
                    <table class="table-custom">
                        <thead>
                            <tr>
                                <th>Factura</th>
                                <th>Fecha</th>
                                <th class="text-right">Subtotal</th>
                                <th class="text-right">IVA</th>
                                <th class="text-right">Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                for (Object[] venta : ventasCliente) {
                                    String numFactura = (String) venta[1];
                                    String fecha = (String) venta[2];
                                    double subtotal = (Double) venta[7];
                                    double iva = (Double) venta[8];
                                    double total = (Double) venta[6];
                            %>
                                <tr>
                                    <td><%= numFactura %></td>
                                    <td><%= fecha %></td>
                                    <td class="text-right">$<%= String.format("%.2f", subtotal) %></td>
                                    <td class="text-right">$<%= String.format("%.2f", iva) %></td>
                                    <td class="text-right"><strong>$<%= String.format("%.2f", total) %></strong></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } %>

                <!-- RESUMEN FINAL DE COSTOS -->
                <div class="section-title">
                    <i class="fas fa-calculator"></i> Resumen de Facturación
                </div>
                <div class="resumen-costos">
                    <div class="resumen-row">
                        <label>Costo de Habitación:</label>
                        <span class="valor">$<%= String.format("%.2f", costoHabitacion) %></span>
                    </div>
                    <div class="resumen-row">
                        <label>Subtotal Minibar:</label>
                        <span class="valor">$<%= String.format("%.2f", subtotalProductos) %></span>
                    </div>
                    <div class="resumen-row">
                        <label>IVA Minibar:</label>
                        <span class="valor">$<%= String.format("%.2f", ivaProductos) %></span>
                    </div>
                    <div class="resumen-row">
                        <label>Total Minibar:</label>
                        <span class="valor">$<%= String.format("%.2f", totalProductos) %></span>
                    </div>
                    <div class="resumen-row total">
                        <label>TOTAL A PAGAR:</label>
                        <span class="monto-grande">$<%= String.format("%.2f", totalGeneral) %></span>
                    </div>
                </div>

                <!-- BOTONES DE ACCIÓN -->
                <div class="btn-group-custom">
                    <button class="btn-custom btn-imprimir" onclick="window.print()">
                        <i class="fas fa-print"></i> Imprimir
                    </button>
                    
                    <a href="ConsultarCheckinServlet" class="btn-custom btn-regresar">
                        <i class="fas fa-arrow-left"></i> Volver
                    </a>
                </div>

            <% } %>

        </div>

        <!-- PIE DE PÁGINA -->
        <div class="factura-footer">
            <p><strong>Sistema de Gestión Hotelera</strong> | Generado el <%= new java.util.Date() %></p>
            <p>By Melanny G & Camilo R</p>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>