<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.dao.UsuarioManager" %>
<%@ page import="hotelweb.models.Habitacion" %>

<%
    // 1. SEGURIDAD DE SESIÓN
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
    if (usuarioLogueado == null) {
        response.sendRedirect("index.jsp?error=sesion_expirada");
        return;
    }

    // 2. RECUPERAR DATOS (Si venimos de buscar)
    Habitacion habFound = (Habitacion) request.getAttribute("habitacionEncontrada");
    
    // Variables para llenar el formulario
    String numVal = (habFound != null) ? habFound.getNumero() : "";
    String tipoVal = (habFound != null) ? habFound.getTipo() : "";
    String precioVal = (habFound != null) ? String.valueOf(habFound.getPrecio()) : "";
    String estadoVal = (habFound != null) ? habFound.getEstado() : "";
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Habitación (Bootstrap Dark)</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #343a40; 
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px 0;
        }
        .form-dark-card {
            max-width: 600px;
            width: 95%;
            background-color: #212529;
            border: none;
        }
        .form-control, .form-select {
            background-color: #495057;
            color: #fff;
            border-color: #6c757d;
        }
        .form-control:focus, .form-select:focus {
            background-color: #495057;
            color: #fff;
            border-color: #0d6efd; 
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .btn-custom-width { width: 100%; }
        .botones-col {
            display: flex; 
            flex-direction: column; 
            justify-content: center;
        }
    </style>
</head>
<body>
    
    <div class="card form-dark-card text-white shadow-lg rounded-3">
        <div class="card-header bg-black text-center py-3 rounded-top-3">
            <h2 class="mb-0">Gestión de Habitaciones</h2>
        </div>
        
        <div class="card-body">
            <% 
                String msj = (String) request.getAttribute("mensaje");
                String err = (String) request.getAttribute("error");
                if(msj != null) out.print("<div class='alert alert-success'>"+msj+"</div>");
                if(err != null) out.print("<div class='alert alert-danger'>"+err+"</div>");
            %>

            <form action="HabitacionServlet" method="post">
                <div class="row g-4">
                    
                    <div class="col-lg-8">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Número de Habitación:</label>
                            <input type="text" class="form-control" name="numero" value="<%= numVal %>" placeholder="Ej: 101" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tipo:</label>
                            <select class="form-select" name="tipo" required>
                                <option value="" disabled <%= tipoVal.isEmpty()?"selected":"" %>>Seleccione...</option>
                                <option value="Simple" <%= "Simple".equalsIgnoreCase(tipoVal)?"selected":"" %>>Simple</option>
                                <option value="Doble" <%= "Doble".equalsIgnoreCase(tipoVal)?"selected":"" %>>Doble</option>
                                <option value="Suite" <%= "Suite".equalsIgnoreCase(tipoVal)?"selected":"" %>>Suite</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Precio por Noche:</label>
                            <input type="number" step="0.01" class="form-control" name="precio" value="<%= precioVal %>" placeholder="0.00" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Estado Actual:</label>
                            <select class="form-select" name="estado" required>
                                <option value="Disponible" <%= "Disponible".equalsIgnoreCase(estadoVal)?"selected":"" %>>Disponible</option>
                                <option value="Ocupado" <%= "Ocupado".equalsIgnoreCase(estadoVal)?"selected":"" %>>Ocupado</option>
                                <option value="Mantenimiento" <%= "Mantenimiento".equalsIgnoreCase(estadoVal)?"selected":"" %>>Mantenimiento</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 botones-col">
                        <div class="d-grid gap-2 mx-auto" style="width: 100%;"> 
                            <button type="submit" name="accion" value="guardar" class="btn btn-primary">Guardar</button>
                            <button type="submit" name="accion" value="buscar" class="btn btn-secondary text-white" formnovalidate>Buscar</button>
                            <button type="submit" name="accion" value="eliminar" class="btn btn-danger" onclick="return confirm('¿Eliminar habitación?');" formnovalidate>Eliminar</button>
                            
                            <a href="NuevaHabitacion.jsp" class="btn btn-light">Nuevo</a>
                            <button type="button" onclick="window.location.href='Menu.jsp';" class="btn btn-info">Regresar</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="card-footer text-end text-muted py-2 bg-black rounded-bottom-3">
            <small>Admin Habitaciones</small>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>