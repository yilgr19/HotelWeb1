<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.dao.UsuarioManager" %>
<%
    // 1. OBTENER EL USUARIO DE LA SESIÓN
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

    // 2. SI NO HAY SESIÓN, ¡AFUERA!
    // (Redirige al login)
    if (usuarioLogueado == null) {
        response.sendRedirect("index.jsp?error=sesion_expirada");
        return;
    }

    // 3. OBTENER EL NOMBRE DE ESTA PÁGINA
    String paginaActual = request.getRequestURI().substring(request.getContextPath().length() + 1);

    // 4. VERIFICAR PERMISO CON EL MANAGER
    if (!UsuarioManager.tieneAccesoPagina(usuarioLogueado, paginaActual)) {
        
        // ¡ACCESO DENEGADO!
        // Redirigimos al usuario a su menú (o una página de error)
        // (Asumiendo que "Menu.jsp" es seguro para todos)
        response.sendRedirect("Menu.jsp?error=acceso_denegado");
        return;
    }

    // Si el código llega hasta aquí, el usuario TIENE PERMISO.
    // La página .jsp se cargará normalmente.
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Consulta de Check-ins</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- CSS de BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <style>
        /* Estilos base */
        body {
            /* Fondo oscuro para la consistencia del sistema */
            background-color: #343a40; 
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 20px 0; 
        }

        /* Estilo para el contenedor principal de la consulta (tarjeta oscura) */
        .consulta-dark-card {
            max-width: 95%; 
            width: 1300px; 
            background-color: #212529; 
            border: none;
            min-height: 85vh; 
            display: flex;
            flex-direction: column;
        }

        /* Estilo para los inputs, select y botones (consistencia visual) */
        .btn-custom {
            width: 150px; 
            font-weight: bold;
        }

        /* Botón de acción principal: Actualizar (Azul) */
        .btn-principal {
            background-color: #0d6efd; 
            border-color: #0d6efd;
            color: white;
        }
        .btn-principal:hover {
            background-color: #0b5ed7; 
            border-color: #0a58ca;
            color: white;
        }

        /* Botón de acción secundaria: Mostrar Todas / Regresar (Gris) */
        .btn-secundario {
            background-color: #6c757d; 
            border-color: #6c757d;
            color: white; 
        }
        .btn-secundario:hover {
            background-color: #5c636a; 
            border-color: #565e64;
            color: white;
        }
        
        /* Botón de Check-out/Finalizar (Rojo) */
        .btn-finalizar {
            background-color: #dc3545; /* Rojo de Bootstrap Danger */
            border-color: #dc3545;
            color: white;
            font-weight: bold;
        }
        .btn-finalizar:hover {
            background-color: #c82333; 
            border-color: #bd2130;
            color: white;
        }

        /* Estilo para la tabla oscura (Bootstrap Dark Table) */
        .table-dark-custom {
            --bs-table-bg: #212529; /* Fondo de tabla oscuro */
            --bs-table-color: #f8f9fa; /* Texto CLARO (blanco) por defecto para toda la tabla */
            --bs-table-border-color: #343a40; /* Borde oscuro */
            margin-top: 20px;
        }
        
        /* FUERZA EL COLOR BLANCO EN EL CUERPO DE LA TABLA para todos los datos que no tienen estado */
        .table-dark-custom tbody tr > * {
            color: #f8f9fa !important; /* Blanco */
        }
        
        /* Asegurar que la tabla ocupe el espacio sin desbordarse horizontalmente en móviles */
        .table-responsive {
            flex-grow: 1; 
            overflow-y: auto; 
        }

        /* Clases de estado condicional (el backend debe aplicarlas) */
        .text-success { /* Activo */
            color: #198754 !important;
            font-weight: bold;
        }
        .text-finalizado { /* Finalizado/Check-out */
            color: #dc3545 !important; /* Rojo de Bootstrap Danger */
            font-weight: bold;
        }
        .text-warning { /* Pendiente/Otro */
            color: #ffc107 !important;
            font-weight: bold;
        }
    </style>
</head>
<body>
    
    <!-- Contenedor principal: Tarjeta oscura (TEXT-WHITE) con sombra -->
    <div class="card consulta-dark-card text-white shadow-lg rounded-3">
        
        <!-- Título/Cabecera de la Tarjeta (BG-BLACK) -->
        <div class="card-header bg-black text-center py-3 rounded-top-3">
            <h2 class="mb-0">Consultar Check-ins</h2>
        </div>
        
        <div class="card-body d-flex flex-column">
            
            <!-- CONTENEDOR DE BOTONES DE ACCIÓN (Centrado horizontalmente) -->
            <div class="d-flex justify-content-center gap-3 mb-4 flex-wrap">
                <button type="button" class="btn btn-secundario btn-custom">Mostrar Todos</button>
                <button type="button" class="btn btn-secundario btn-custom">Solo Activos</button>
                <button type="button" class="btn btn-secundario btn-custom">Solo Finalizados</button>
                <button type="button" class="btn btn-principal btn-custom">Actualizar</button>
                <button type="button" class="btn btn-finalizar btn-custom">Check-out</button>
                <button type="button" onclick="window.history.back();" class="btn btn-secundario btn-custom">Regresar</button>
            </div>

            <!-- TABLA DE RESULTADOS (Responsive para móviles) -->
            <div class="table-responsive">
                <table class="table table-dark-custom table-striped table-hover rounded-3">
                    <thead>
                        <tr>
                            <!-- Columnas de datos del Check-in -->
                            <th scope="col"># ID Check-in</th>
                            <th scope="col">Huésped (Nombre)</th>
                            <th scope="col">Apellido</th>
                            <th scope="col">Cédula</th>
                            <th scope="col">Teléfono</th>
                            <th scope="col">F. Ingreso</th>
                            <th scope="col">F. Salida</th>
                            <th scope="col">Días</th>
                            <th scope="col">Habitación</th>
                            <th scope="col">Alergias</th>
                            <th scope="col">Estado</th>
                            <th scope="col">Observaciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 
                            *** IMPORTANTE: Esta sección debe ser llenada dinámicamente por el código de servidor (ej. JSP) *** El código de servidor debe generar filas (<tr>) y aplicar las clases 
                            condicionales (text-success, text-finalizado, text-warning) a la celda <td> del Estado.
                            Ejemplo de fila (que el servidor generaría):
                            <tr>
                                <th scope="row">C001</th>
                                <td>Nombre</td>
                                <td>Apellido</td>
                                <td>Cédula</td>
                                <td>...</td>
                                <td class="text-success fw-bold">Activo</td>
                                <td>...</td>
                            </tr>
                        -->
                    </tbody>
                </table>
                
                <!-- Mensaje de no resultados (oculto por defecto) -->
                <p id="no-checkins-msg" class="text-center text-muted mt-5" style="display:block;">
                    No hay check-ins registrados o que coincidan con los criterios de búsqueda.
                </p>
            </div>
        </div>
        
        <!-- Pie de página opcional para la tarjeta -->
        <div class="card-footer text-end text-muted py-2 bg-black rounded-bottom-3">
            <small>Sistema de Gestión de Check-ins - Consulta</small>
        </div>
    </div>
    
    <!-- JavaScript de BOOTSTRAP -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
    <script>
        // Lógica de ejemplo para mostrar/ocultar mensaje (en producción esto lo haría el servidor)
        window.onload = function() {
            const tableBody = document.querySelector('.table-dark-custom tbody');
            const noCheckinsMsg = document.getElementById('no-checkins-msg');
            
            // Si el código de servidor (JSP) insertara filas, el mensaje de "No hay..." debería ocultarse.
            if (tableBody && tableBody.rows.length > 0) {
                noCheckinsMsg.style.display = 'none';
            } else {
                noCheckinsMsg.style.display = 'block';
            }
        };
    </script>
</body>
</html>