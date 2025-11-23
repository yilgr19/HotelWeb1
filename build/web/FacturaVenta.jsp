<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="hotelweb.models.Venta" %>
<%@ page import="hotelweb.models.DetalleVenta" %>
<%
    // Recupera el objeto Venta guardado por el Servlet
    Venta venta = (Venta) request.getAttribute("ventaExitosa");
    if(venta == null) { 
        // Si no se encuentra, redirige o muestra un error
        response.sendRedirect("NuevaVenta.jsp"); 
        return; 
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Factura <%= venta.getNumFactura() %></title>
    <style>
        body { font-family: monospace; width: 300px; margin: 0 auto; }
        .center { text-align: center; }
        .line { border-bottom: 1px dashed black; margin: 5px 0; }
        .table { width: 100%; font-size: 12px; }
        .right { text-align: right; }
        @media print { .no-print { display: none; } }
    </style>
</head>
<body>
    <div class="center">
        <h3>HOTEL SYSTEM</h3>
        <p>FACTURA DE VENTA<br>N° **<%= venta.getNumFactura() %>**</p>
    </div>
    
    <p>
        Fecha: <%= venta.getFecha() %> <%= venta.getHora() %><br>
        Cliente: <%= venta.getNombre() %><br>
        Pago: <%= venta.getMetodoPago() %>
    </p>
    
    <div class="line"></div>
    <table class="table">
        <tr><td>DESC</td><td>CANT</td><td class="right">VALOR</td></tr>
        <% for(DetalleVenta d : venta.getDetalles()) { %>
        <tr>
            <td><%= d.getNombreProducto() %></td>
            <td><%= d.getCantidad() %></td>
            <td class="right"><%= String.format("%.2f", d.getSubtotal()) %></td>
        </tr>
        <% } %>
    </table>
    <div class="line"></div>
    
    <table class="table">
        <tr><td>SUBTOTAL (BASE):</td><td class="right"><%= String.format("%.2f", venta.getSubtotal()) %></td></tr>
        <tr><td>IVA:</td><td class="right"><%= String.format("%.2f", venta.getIvaTotal()) %></td></tr>
        <tr><td><strong>TOTAL:</strong></td><td class="right"><strong><%= String.format("%.2f", venta.getTotalVenta()) %></strong></td></tr>
    </table>
    
    <br>
    <div class="center">
        <p>¡Gracias por su compra!</p>
        <button onclick="window.print()" class="no-print btn btn-sm btn-primary">IMPRIMIR FACTURA</button>
        <a href="NuevaVenta.jsp" class="no-print btn btn-sm btn-secondary">Nueva Venta</a>
    </div>
</body>
</html>