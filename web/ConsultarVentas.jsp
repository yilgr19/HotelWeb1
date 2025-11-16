
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Consultar Ventas</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #343a40; /* Fondo oscuro similar a tus imágenes */
            color: #f8f9fa;
            padding: 20px;
        }
        .container {
            max-width: 95%;
        }
        .card {
            background-color: #212529; /* Color de tarjeta/área de contenido */
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
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Consultar Ventas</h2>
    <div class="card p-3">
        
        <div class="d-flex justify-content-start mb-3">
            <a href="NuevaVenta.jsp" class="btn btn-success mr-2">Nueva Venta</a>
            <button class="btn btn-secondary mr-2">Buscar</button>
            <button class="btn btn-info mr-2">Exportar</button>
            <button type="button" onclick="window.location.href='Menu.jsp';" class="btn btn-info btn-responsive">Regresar</button>
        </div>

        <div class="mb-3">
            <form action="VentasController" method="get" class="form-inline">
                <input type="hidden" name="action" value="buscar">
                <label for="fechaIni" class="mr-2">Fecha Inicio:</label>
                <input type="date" id="fechaIni" name="fechaIni" class="form-control mr-3 bg-dark text-white border-secondary">
                
                <label for="fechaFin" class="mr-2">Fecha Fin:</label>
                <input type="date" id="fechaFin" name="fechaFin" class="form-control mr-3 bg-dark text-white border-secondary">

                <button type="submit" class="btn btn-sm btn-outline-light">Filtrar</button>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-dark table-hover table-sm">
                <thead>
                    <tr>
                        <th>ID Venta</th>
                        <th>Fecha</th>
                        <th>Cédula Cliente</th>
                        <th>Nombre Cliente</th>
                        <th>Tipo Pago</th>
                        <th>Total Venta</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="venta" items="${listaVentas}">
                        <tr>
                            <td><c:out value="${venta.idVenta}"/></td>
                            <td><c:out value="${venta.fecha}"/></td>
                            <td><c:out value="${venta.cedulaCliente}"/></td>
                            <td><c:out value="${venta.nombreCliente}"/></td>
                            <td><c:out value="${venta.tipoPago}"/></td>
                            <td><c:out value="${venta.totalVenta}"/></td>
                            <td><c:out value="${venta.estado}"/></td>
                            <td>
                                <a href="detalleVenta.jsp?id=${venta.idVenta}" class="btn btn-sm btn-primary">Ver Detalle</a>
                                <a href="VentasController?action=anular&id=${venta.idVenta}" class="btn btn-sm btn-danger">Anular</a>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty listaVentas}">
                        <tr>
                            <td colspan="8" class="text-center">No se encontraron ventas.</td>
                        </tr>
                    </c:if>

                </tbody>
            </table>
        </div>
        
    </div>
</div>

</body>
</html>