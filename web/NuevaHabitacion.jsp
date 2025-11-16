<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Habitación (Bootstrap Dark)</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- CSS de BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <style>
        /* Estilos base para centrar el formulario en la página */
        body {
            /* Usamos un fondo oscuro para que la tarjeta contraste */
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
            /* Fondo gris oscuro, similar al cuerpo del formulario de Cliente */
            background-color: #212529; 
            border: none;
        }

        /* Estilo para los inputs, select y textarea para que contrasten mejor */
        .form-control, .form-select {
            background-color: #495057; /* Fondo de campo gris oscuro */
            color: #fff; /* Texto blanco en los campos */
            border-color: #6c757d;
        }

        .form-control:focus, .form-select:focus {
            background-color: #495057;
            color: #fff;
            border-color: #0d6efd; 
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        
        /* Ajuste para que los botones sean más anchos (como en el formulario de Cliente) */
        .btn-custom-width {
            width: 100px; 
        }

        /* Ajuste para la columna de botones en pantallas grandes (Lg) */
        @media (min-width: 992px) {
            .botones-col {
                /* Pequeño ajuste de padding para alinear con el primer campo */
                padding-top: 1.25rem !important; 
            }
        }
    </style>
</head>
<body>
    
    <!-- Contenedor principal: Tarjeta oscura (TEXT-WHITE) con sombra -->
    <div class="card form-dark-card text-white shadow-lg rounded-3">
        
        <!-- Título/Cabecera de la Tarjeta (BG-BLACK simula la barra del Navbar) -->
        <div class="card-header bg-black text-center py-3 rounded-top-3">
            <h2 class="mb-0">Registro de Habitación</h2>
        </div>
        
        <div class="card-body">
            <form action="HabitacionServlet" method="post">
                
                <!-- ROW principal para campos y botones, usando espaciado 'g-3' -->
                <div class="row g-3">
                    
                    <!-- COLUMNA 1: CAMPOS DEL FORMULARIO (ocupa 8 de 12 columnas en pantallas grandes) -->
                    <div class="col-lg-8">
                        
                        <!-- Numero -->
                        <div class="mb-3">
                            <label for="numero" class="form-label fw-bold">Numero:</label>
                            <input type="text" class="form-control" id="numero" name="numero" required>
                        </div>

                        <!-- Precio -->
                        <div class="mb-3">
                            <label for="precio" class="form-label fw-bold">Precio:</label>
                            <!-- Usamos input type text para mayor flexibilidad o number si es necesario -->
                            <input type="number" class="form-control" id="precio" name="precio" required step="0.01">
                        </div>

                        <!-- Descripcion (Usamos textarea para el campo grande) -->
                        <div class="mb-3">
                            <label for="descripcion" class="form-label fw-bold">Descripcion:</label>
                            <textarea class="form-control" id="descripcion" name="descripcion" rows="4"></textarea>
                        </div>

                        <!-- Estado (Usamos select/dropdown) -->
                        <div class="mb-3">
                            <label for="estado" class="form-label fw-bold">Estado:</label>
                            <select class="form-select" id="estado" name="estado">
                                <option value="desocupado">Desocupado</option>
                                <option value="ocupado">Ocupado</option>
                                <option value="mantenimiento">Mantenimiento</option>
                            </select>
                        </div>

                        <!-- Disponibilidad -->
                        <div class="mb-3">
                            <label for="disponibilidad" class="form-label fw-bold">Disponibilidad:</label>
                            <input type="date" class="form-control" id="disponibilidad" name="disponibilidad">
                        </div>
                        
                    </div>
                    
                    <!-- COLUMNA 2: BOTONES (USANDO D-GRID Y GAP-2, alineado con el de Cliente) -->
                    <div class="col-lg-4 botones-col">
                        <!-- d-grid: Columna de botones. gap-2: Espaciado compacto. mx-auto: Centrado. -->
                        <div class="d-grid gap-2 mx-auto"> 
                            <button type="submit" name="accion" value="guardar" class="btn btn-primary btn-custom-width">Guardar</button>
                            <button type="submit" name="accion" value="eliminar" class="btn btn-secondary btn-custom-width">Eliminar</button>
                            <button type="submit" name="accion" value="buscar" class="btn btn-secondary btn-custom-width">Buscar</button>
                            <button type="button" onclick="window.location.reload();" class="btn btn-secondary btn-custom-width">Nuevo</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    
    <!-- JavaScript de BOOTSTRAP -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>