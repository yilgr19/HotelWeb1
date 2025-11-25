<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.dao.UsuarioManager" %>
<%@ page import="hotelweb.models.Cliente" %> <%-- <-- Importa el modelo Cliente --%>
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
    
    
    // --- LÓGICA PARA "BUSCAR" Y RELLENAR EL FORMULARIO ---
    // (Este es el ÚNICO bloque que define la variable 'cliente')
    Cliente cliente = (Cliente) request.getAttribute("clienteEncontrado");
    if (cliente == null) {
        // Si no se buscó nada, creamos un cliente vacío para evitar errores
        cliente = new Cliente();
    }
    // --------------------------------------------------------
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registra Nuevo Cliente</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <style>
        /* Estilos base para centrar el formulario en la página */
        body {
            background-color: #343a40;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        

        /* Estilo para el contenedor del formulario que lo hace oscuro como el Navbar */
        .form-dark-card {
            max-width: 650px; 
            width: 90%;
            background-color: #212529; 
            border: none;
        }

        /* Estilo para los inputs para que contrasten mejor */
        .form-control, .form-select {
            background-color: #495057; 
            color: #fff; 
            border-color: #6c757d;
        }

        .form-control:focus {
            background-color: #495057;
            color: #fff;
            border-color: #0d6efd; 
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        
        /* Ajuste para que los botones sean más anchos */
        .btn-custom-width {
            width: 100px;
            height: 40px;/* Ancho fijo como en tu CSS original */
        }
        
        /* Ajuste para la columna de botones en pantallas grandes (Lg) */
        @media (min-width: 992px) {
            .botones-col {
                padding-top: 1.25rem !important; 
                justify-self: center; 
            }
        }
    </style>
</head>
<body>
    
    <div class="card form-dark-card text-white shadow-lg">
        
        <div class="card-header bg-black text-center py-3">
            <h2 class="mb-0">Registra Cliente</h2>
        </div>
        
        <div class="card-body">

            <%-- 
              --- BLOQUE DE MENSAJES DE ÉXITO/ERROR ---
            --%>
            <% 
                String error = (String) request.getAttribute("error");
                String mensaje = (String) request.getAttribute("mensaje");
                
                if (error != null) {
                    out.println("<div class='alert alert-danger' role='alert'>" + error + "</div>");
                }
                if (mensaje != null) {
                    out.println("<div class='alert alert-success' role='alert'>" + mensaje + "</div>");
                }
            %>
            <%-- --- FIN DEL BLOQUE DE MENSAJES --- --%>

            
            <form action="ClienteServlet" method="post">
                
                <div class="row g-3">
                    
                    <div class="col-lg-8">
                        
                        <div class="mb-3">
                            <label for="cedula" class="form-label fw-bold">Cedula:</label>
                            <input type="text" class="form-control" id="cedula" name="cedula" 
                                   value="<%= (cliente.getCedula() != null) ? cliente.getCedula() : "" %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="nombre" class="form-label fw-bold">Nombre:</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" 
                                   value="<%= (cliente.getNombre() != null) ? cliente.getNombre() : "" %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="apellido" class="form-label fw-bold">Apellido:</label>
                            <input type="text" class="form-control" id="apellido" name="apellido" 
                                   value="<%= (cliente.getApellido() != null) ? cliente.getApellido() : "" %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="telefono" class="form-label fw-bold">Telefono:</label>
                            <input type="tel" class="form-control" id="telefono" name="telefono"
                                   value="<%= (cliente.getTelefono() != null) ? cliente.getTelefono() : "" %>">
                        </div>

                        <div class="mb-3">
                            <label for="direccion" class="form-label fw-bold">Direccion:</label>
                            <input type="text" class="form-control" id="direccion" name="direccion"
                                   value="<%= (cliente.getDireccion() != null) ? cliente.getDireccion() : "" %>">
                        </div>

                        <div class="mb-3">
                            <label for="correo" class="form-label fw-bold">Correo:</label>
                            <input type="email" class="form-control" id="correo" name="correo"
                                   value="<%= (cliente.getCorreo() != null) ? cliente.getCorreo() : "" %>">
                        </div>
                        
                    </div>
                    
                    <div class="col-lg-4 botones-col">
                        <div class="d-grid gap-2 mx-auto"> 
                            
                            <button type="submit" name="accion" value="guardar" class="btn btn-primary btn-custom-width">Guardar</button>
                            
                            <button type="submit" name="accion" value="eliminar" class="btn btn-danger btn-custom-width" formnovalidate>Eliminar</button>
                            <button type="submit" name="accion" value="buscar" class="btn btn-secondary btn-custom-width" formnovalidate>Buscar</button>
                            
                            <button type="button" onclick="window.location.href='NuevoCliente.jsp';" class="btn btn-light btn-custom-width">Nuevo</button>
                            <button type="button" onclick="window.location.href='Menu.jsp';" class="btn btn-info btn-custom-width ">Regresar</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
</body>
</html>