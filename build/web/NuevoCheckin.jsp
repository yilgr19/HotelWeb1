<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Check-in de Huéspedes (Bootstrap Dark)</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- CSS de BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <style>
        /* Estilos base para centrar la tarjeta */
        body {
            /* Fondo oscuro para la consistencia del sistema */
            background-color: #343a40; 
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            /* Se elimina el padding vertical excesivo para usar el espacio */
            padding: 10px 0; 
        }

        /* Estilo para el contenedor del formulario que lo hace oscuro */
        .form-dark-card {
            /* Aumentamos el ancho máximo para utilizar más espacio horizontal */
            max-width: 800px; 
            width: 95%;
            /* Fondo gris oscuro, consistente con otros formularios */
            background-color: #212529; 
            border: none;
            /* Se asegura que la tarjeta se adapte al alto de la pantalla si es necesario */
            min-height: 85vh; 
            display: flex; /* Añadido para mejor control del contenido */
            flex-direction: column;
        }

        /* Aseguramos que el cuerpo de la tarjeta ocupe el espacio restante */
        .card-body {
            flex-grow: 1;
        }

        /* Estilo para los inputs, select y textarea */
        .form-control, .form-select {
            background-color: #495057; /* Fondo de campo gris oscuro */
            color: #fff; /* Texto blanco */
            border-color: #6c757d;
        }

        .form-control:focus, .form-select:focus {
            background-color: #495057;
            color: #fff;
            border-color: #0d6efd; 
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        
        /* Ajuste para que los botones de CRUD sean del mismo tamaño */
        .btn-custom-width {
            width: 130px; 
        }
        
        /* Estilo ÚNICO para el botón principal (Azul Primario) - Guardar Check-in */
        .btn-principal {
            background-color: #0d6efd; /* Azul Primario */
            border-color: #0d6efd;
            color: white;
            font-weight: bold;
        }
        .btn-principal:hover {
            background-color: #0b5ed7; 
            border-color: #0a58ca;
            color: white;
        }

        /* Estilo para acciones de TERMINACIÓN/ELIMINACIÓN (Rojo Peligro) */
        .btn-danger-custom {
            background-color: #dc3545; /* Rojo de Bootstrap Danger */
            border-color: #dc3545;
            color: white;
            font-weight: bold;
        }
        .btn-danger-custom:hover {
            background-color: #c82333;
            border-color: #bd2130;
            color: white;
        }


        /* Estilo para botones secundarios (Gris) - Buscar, Nuevo, Regresar */
        .btn-secundario {
            background-color: #6c757d; /* Gris secundario */
            border-color: #6c757d;
            color: white;
            font-weight: bold; 
        }
        .btn-secundario:hover {
            background-color: #5c636a; 
            border-color: #565e64;
            color: white;
        }
        
        /* Ajuste de espaciado para que no haya scroll innecesario */
        .h4-margin {
            margin-bottom: 1.5rem !important;
        }
    </style>
</head>
<body>
    
    <!-- Contenedor principal: Tarjeta oscura (TEXT-WHITE) con sombra -->
    <div class="card form-dark-card text-white shadow-lg rounded-3">
        
        <!-- Título/Cabecera de la Tarjeta (BG-BLACK) -->
        <div class="card-header bg-black text-center py-3 rounded-top-3">
            <h2 class="mb-0">Gestión de Check-in</h2>
        </div>
        
        <div class="card-body">
            <!-- Título de sección dentro del cuerpo -->
            <h4 class="text-white h4-margin">CHECK-IN DE HUÉSPEDES</h4>
            
            <form action="CheckinServlet" method="post">
                
                <!-- ROW PRINCIPAL: Campos y Botones -->
                <div class="row g-4">
                    
                    <!-- COLUMNA 1: CAMPOS DEL FORMULARIO (ocupa 8 de 12 columnas) -->
                    <div class="col-lg-8">
                        
                        <!-- Nombre y Apellido en la misma fila para ahorrar espacio -->
                        <div class="row g-3 mb-3">
                            <!-- Nombre -->
                            <div class="col-md-6">
                                <label for="nombre" class="form-label fw-bold">Nombre:</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                            </div>
                            <!-- Apellido -->
                            <div class="col-md-6">
                                <label for="apellido" class="form-label fw-bold">Apellido:</label>
                                <input type="text" class="form-control" id="apellido" name="apellido" required>
                            </div>
                        </div>

                        <!-- Cédula y Teléfono en la misma fila -->
                        <div class="row g-3 mb-3">
                            <!-- Cédula -->
                            <div class="col-md-6">
                                <label for="cedula" class="form-label fw-bold">Cédula:</label>
                                <input type="text" class="form-control" id="cedula" name="cedula" required>
                            </div>
                            <!-- Teléfono -->
                            <div class="col-md-6">
                                <label for="telefono" class="form-label fw-bold">Teléfono:</label>
                                <input type="text" class="form-control" id="telefono" name="telefono">
                            </div>
                        </div>
                        
                        <!-- Fechas de Ingreso y Salida en la misma fila -->
                        <div class="row g-3 mb-3">
                            <!-- Fecha de Ingreso -->
                            <div class="col-md-6">
                                <label for="fechaIngreso" class="form-label fw-bold">Fecha de Ingreso:</label>
                                <input type="date" class="form-control" id="fechaIngreso" name="fechaIngreso" required>
                            </div>
                            <!-- Fecha de Salida -->
                            <div class="col-md-6">
                                <label for="fechaSalida" class="form-label fw-bold">Fecha de Salida:</label>
                                <input type="date" class="form-control" id="fechaSalida" name="fechaSalida" required>
                            </div>
                        </div>
                        
                        <!-- Habitación (Select) -->
                        <div class="mb-3">
                            <label for="habitacion" class="form-label fw-bold">Habitación:</label>
                            <select class="form-select" id="habitacion" name="habitacion" required>
                                <option value="" selected disabled>Seleccione habitación</option>
                                <option value="101">101 - Simple</option>
                                <option value="205">205 - Doble</option>
                                <option value="301">301 - Suite</option>
                            </select>
                        </div>

                        <!-- Alergias y Días de Hospedaje en la misma fila -->
                        <div class="row g-3 mb-3">
                            <!-- Alergias -->
                            <div class="col-md-8">
                                <label for="alergias" class="form-label fw-bold">Alergias:</label>
                                <input type="text" class="form-control" id="alergias" name="alergias" placeholder="Ninguna">
                            </div>
                            <!-- Días de Hospedaje (Campo de sólo lectura calculado por el sistema) -->
                            <div class="col-md-4">
                                <label for="diasHospedaje" class="form-label fw-bold">Días de Hospedaje:</label>
                                <input type="number" class="form-control" id="diasHospedaje" name="diasHospedaje" value="0" readonly>
                            </div>
                        </div>

                        <!-- Observaciones (Texto grande) -->
                        <div class="mb-3">
                            <label for="observaciones" class="form-label fw-bold">Observaciones:</label>
                            <textarea class="form-control" id="observaciones" name="observaciones" rows="3"></textarea>
                        </div>
                        
                    </div>
                    
                    <!-- COLUMNA 2: BOTONES (ocupa 4 de 12 columnas) -->
                    <div class="col-lg-4">
                        <!-- d-grid gap-3: mantiene el espaciado entre botones -->
                        <!-- mt-lg-5 pt-lg-3: Espaciado superior para alinear los botones verticalmente con los campos -->
                        <div class="d-grid gap-3 mx-auto mt-lg-5 pt-lg-3">
                            
                            <!-- Botón 1: Guardar Check-in (ÚNICO PRINCIPAL, AZUL) -->
                            <button type="submit" name="accion" value="guardar_checkin" class="btn btn-principal btn-custom-width">Guardar Check-in</button>

                            <!-- Botón 2: Buscar (Secundario, Gris) -->
                            <button type="submit" name="accion" value="buscar" class="btn btn-secundario btn-custom-width">Buscar</button>
                            
                            <!-- Botón 3: Eliminar (Acción Terminal, Rojo) -->
                            <button type="submit" name="accion" value="eliminar" class="btn btn-danger-custom btn-custom-width">Eliminar</button>
                            
                            <!-- Botón 4: Nuevo (Secundario, Gris) -->
                            <button type="button" onclick="window.location.reload();" class="btn btn-secundario btn-custom-width">Nuevo</button>
                            
                            <!-- Botón 5: Finalizar Check-in (Acción Terminal, Rojo) -->
                            <button type="submit" name="accion" value="finalizar_checkin" class="btn btn-danger-custom btn-custom-width">Finalizar Check-in</button>

                            <!-- Botón 6: Regresar (Secundario, Gris) -->
                            <button type="button" onclick="window.history.back();" class="btn btn-secundario btn-custom-width">Regresar</button>
                            
                        </div>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- Pie de página opcional para la tarjeta -->
        <div class="card-footer text-end text-muted py-2 bg-black rounded-bottom-3">
            <small>Sistema de Gestión de Check-in</small>
        </div>
    </div>
    
    <!-- JavaScript de BOOTSTRAP -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>