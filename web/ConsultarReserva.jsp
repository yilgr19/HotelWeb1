<%@ page import="hotelweb.controllers.Usuario" %>
<%@ page import="hotelweb.controllers.UsuarioManager" %>
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
    <title>Consulta de Reservas</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- CSS de BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <style>
        /* Estilos base */
        body {
            /* Fondo oscuro para la consistencia del sistema */
            background-color: #343a40; 
            min-height: 100vh;
            /* Flexbox para centrar el contenido principal */
            display: flex;
            justify-content: center;
            align-items: flex-start; /* Alineado arriba, no al centro completo, para parecer una aplicación de escritorio */
            padding: 20px 0; 
        }

        /* Estilo para el contenedor principal de la consulta (tarjeta oscura) */
        .consulta-dark-card {
            max-width: 95%; /* Usar casi todo el ancho disponible */
            width: 1200px; /* Un ancho máximo generoso para la tabla */
            background-color: #212529; /* Fondo gris oscuro */
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
            flex-grow: 1; /* Permite que el área de la tabla crezca */
            overflow-y: auto; /* Permite scroll vertical si la tabla es muy larga */
        }

        /* Clases de estado condicional (el backend debe aplicarlas) */
        .text-success { /* Confirmada (Verde) */
            color: #198754 !important;
            font-weight: bold;
        }
        .text-cancelada { /* Cancelada/Eliminada (Rojo) */
            color: #dc3545 !important; 
            font-weight: bold;
        }
        .text-warning { /* Pendiente (Amarillo) */
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
            <h2 class="mb-0">Consultar Reservas</h2>
        </div>
        
        <div class="card-body d-flex flex-column">
            
            <!-- CONTENEDOR DE BOTONES DE ACCIÓN (Centrado horizontalmente) -->
            <div class="d-flex justify-content-center gap-3 mb-4">
                <button type="button" class="btn btn-secundario btn-custom">Mostrar Todas</button>
                <button type="button" class="btn btn-principal btn-custom">Actualizar</button>
                <button type="button" onclick="window.history.back();" class="btn btn-secundario btn-custom">Regresar</button>
            </div>

            <!-- TABLA DE RESULTADOS (Responsive para móviles) -->
            <div class="table-responsive">
                <table class="table table-dark-custom table-striped table-hover rounded-3">
                    <thead>
                        <tr>
                            <!-- Aseguramos que todas las columnas de datos de reserva estén presentes -->
                            <th scope="col"># ID</th>
                            <th scope="col">Huésped (Nombre)</th>
                            <th scope="col">Cédula</th>
                            <th scope="col">Habitación</th>
                            <th scope="col">Tipo Hab.</th>
                            <th scope="col">F. Entrada</th>
                            <th scope="col">H. Entrada</th>
                            <th scope="col">F. Salida</th>
                            <th scope="col">H. Salida</th>
                            <th scope="col">Estado</th>
                            <th scope="col">Método Pago</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 
                            *** IMPORTANTE: Esta sección debe ser llenada dinámicamente por el código de servidor (ej. JSP/Servlet) *** El código de servidor debe generar filas (<tr>) por cada registro de reserva. 
                            Debe aplicar las clases condicionales (text-success, text-cancelada, text-warning) a la celda <td> del Estado.
                            
                            Ejemplo de cómo el servidor debe generar una fila (NO ELIMINAR ESTE COMENTARIO):
                            <tr>
                                <th scope="row">R001</th>
                                <td>Nombre del Huésped</td>
                                <td>Cédula</td>
                                <td># Habitación</td>
                                <td>Tipo de Hab.</td>
                                <td>Fecha Entrada</td>
                                <td>Hora Entrada</td>
                                <td>Fecha Salida</td>
                                <td>Hora Salida</td>
                                <td class="text-success fw-bold">Estado Dinámico</td> 
                                <td>Método Pago</td>
                            </tr>
                        -->
                    </tbody>
                </table>
                
                <!-- Mensaje de no resultados (oculto por defecto) -->
                <p id="no-reservas-msg" class="text-center text-muted mt-5" style="display:none;">
                    No hay reservas registradas o que coincidan con los criterios de búsqueda.
                </p>
            </div>
        </div>
        
        <!-- Pie de página opcional para la tarjeta -->
        <div class="card-footer text-end text-muted py-2 bg-black rounded-bottom-3">
            <small>Sistema de Gestión de Reservas - Consulta</small>
        </div>
    </div>
    
    <!-- JavaScript de BOOTSTRAP -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
    <!-- Lógica de ejemplo JSP (Se debe reemplazar por código JSP real) -->
    <script>
        // Función placeholder para simular el comportamiento de Regresar
        document.querySelector('button[onclick="window.history.back();"]').addEventListener('click', function() {
            console.log('Regresando a la página anterior...');
        });
        
        // Simulación de que el JSP manejaría el estado de la tabla
        window.onload = function() {
            const tableBody = document.querySelector('.table-dark-custom tbody');
            const noReservasMsg = document.getElementById('no-reservas-msg');
            
            // Si el tbody no tiene filas, muestra el mensaje de no hay reservas (por defecto estará visible)
            if (tableBody && tableBody.rows.length === 0) {
                noReservasMsg.style.display = 'block';
            } else {
                noReservasMsg.style.display = 'none';
            }
        };
    </script>
</body>
</html>