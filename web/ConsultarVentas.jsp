<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.models.Venta" %>
<%@ page import="hotelweb.dao.VentaDAO" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
    if (usuarioLogueado == null) { 
        response.sendRedirect("index.jsp?error=sesion_expirada"); 
        return; 
    }
    
    // SI NO HAY LISTA DE VENTAS, CARGARLAS AUTOMATICAMENTE
    @SuppressWarnings("unchecked")
    List<Venta> listaVentas = (List<Venta>) request.getAttribute("listaVentas");
    if (listaVentas == null) {
        // Cargar todas las ventas desde el DAO
        VentaDAO dao = new VentaDAO();
        listaVentas = dao.obtenerTodasLasVentas();
        request.setAttribute("listaVentas", listaVentas);
    }
    
    String mensaje = (String) request.getAttribute("mensaje");
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Consultar Ventas</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #343a40;
            color: #f8f9fa;
            padding: 20px;
        }
        .container {
            max-width: 95%;
        }
        .card {
            background-color: #212529;
            border: 1px solid #495057;
        }
        .table-responsive {
            margin-top: 20px;
        }
        .table thead th {
            color: #adb5bd;
            background-color: #495057;
        }
        .table tbody tr {
            color: #f8f9fa;
        }
        .alert {
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Consultar Ventas</h2>
    
    <% if (mensaje != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= mensaje %>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    <% } %>
    
    <% if (error != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= error %>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    <% } %>
    
    <div class="card p-3">
        
        <div class="d-flex justify-content-start mb-3">
            <a href="NuevaVenta.jsp" class="btn btn-success mr-2">Nueva Venta</a>
            <button class="btn btn-info mr-2" onclick="location.reload()">Refrescar</button>
            <button type="button" onclick="window.location.href='Menu.jsp';" class="btn btn-secondary">Regresar</button>
        </div>

        <div class="mb-3">
            <form action="VentasController" method="get" class="form-inline">
                <input type="hidden" name="action" value="buscar">
                <label for="fechaIni" class="mr-2">Fecha Inicio:</label>
                <input type="date" id="fechaIni" name="fechaIni" class="form-control mr-3 bg-dark text-white border-secondary">
                
                <label for="fechaFin" class="mr-2">Fecha Fin:</label>
                <input type="date" id="fechaFin" name="fechaFin" class="form-control mr-3 bg-dark text-white border-secondary">

                <button type="submit" class="btn btn-sm btn-outline-light">Filtrar</button>
                <a href="VentasController?action=listar" class="btn btn-sm btn-outline-secondary ml-2">Limpiar</a>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-dark table-hover table-sm">
                <thead>
                    <tr>
                        <th>ID Venta</th>
                        <th>Factura</th>
                        <th>Fecha</th>
                        <th>Cédula Cliente</th>
                        <th>Nombre Cliente</th>
                        <th>Tipo Pago</th>
                        <th>Total Venta</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (listaVentas != null && listaVentas.size() > 0) { %>
                        <% for (Venta venta : listaVentas) { %>
                            <tr>
                                <td><%= venta.getIdVenta() %></td>
                                <td><%= venta.getNumeroFactura() %></td>
                                <td><%= venta.getFecha() %></td>
                                <td><%= venta.getCedulaCliente() %></td>
                                <td><%= venta.getNombreCliente() %></td>
                                <td><%= venta.getMetodoPago() %></td>
                                <td>$<%= String.format("%.2f", venta.getTotalVenta()) %></td>
                                <td>
                                    <a href="VentasController?action=anular&id=<%= venta.getIdVenta() %>" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('¿Deseas anular esta venta?');">
                                        Anular
                                    </a>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="8" class="text-center">No se encontraron ventas.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

</body>
</html>