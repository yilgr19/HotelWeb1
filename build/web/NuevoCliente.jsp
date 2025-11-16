<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registra Nuevo Cliente (Bootstrap Dark - Columna)</title>
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
                /* Pequeño ajuste de padding para alinear con el primer campo */
                padding-top: 1.25rem !important; 
                /* Centrar la rejilla (d-grid) dentro de la columna */
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
            <form action="ClienteServlet" method="post">
                
                <div class="row g-3">
                    
                    <div class="col-lg-8">
                        
                        <div class="mb-3">
                            <label for="cedula" class="form-label fw-bold">Cedula:</label>
                            <input type="text" class="form-control" id="cedula" name="cedula" required>
                        </div>

                        <div class="mb-3">
                            <label for="nombre" class="form-label fw-bold">Nombre:</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" required>
                        </div>

                        <div class="mb-3">
                            <label for="apellido" class="form-label fw-bold">Apellido:</label>
                            <input type="text" class="form-control" id="apellido" name="apellido" required>
                        </div>

                        <div class="mb-3">
                            <label for="telefono" class="form-label fw-bold">Telefono:</label>
                            <input type="tel" class="form-control" id="telefono" name="telefono">
                        </div>

                        <div class="mb-3">
                            <label for="direccion" class="form-label fw-bold">Direccion:</label>
                            <input type="text" class="form-control" id="direccion" name="direccion">
                        </div>

                        <div class="mb-3">
                            <label for="correo" class="form-label fw-bold">Correo:</label>
                            <input type="email" class="form-control" id="correo" name="correo">
                        </div>
                        
                    </div>
                    
                    <div class="col-lg-4 botones-col">
                        <div class="d-grid gap-2 mx-auto"> 
                            <button type="submit" name="accion" value="guardar" class="btn btn-primary btn-custom-width">Guardar</button>
                            <button type="submit" name="accion" value="eliminar" class="btn btn-secondary btn-custom-width">Eliminar</button>
                            <button type="submit" name="accion" value="buscar" class="btn btn-secondary btn-custom-width">Buscar</button>
                            <button type="button" onclick="window.location.reload();" class="btn btn-secondary btn-custom-width">Nuevo</button>
                            
                                 <!-- NUEVO BOTÓN DE REGRESO AL MENÚ -->
                            <button type="button" onclick="window.location.href='Menu.jsp';" class="btn btn-secondary btn-custom-width">Regresar</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>