<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Hotel - Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- CSS de BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <style>
        /* Estilos base para el fondo oscuro */
        body {
            /* Fondo oscuro para la consistencia del sistema */
            background-color: #343a40; 
            min-height: 100vh;
            /* Centrar el contenido vertical y horizontalmente */
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px; 
        }

        /* Estilo para el contenedor del login (tarjeta oscura) */
        .login-card {
            max-width: 450px; 
            width: 90%; /* Responsive en móviles */
            background-color: #212529; /* Fondo gris oscuro */
            border: none;
            /* Sombra y esquinas redondeadas */
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
        }

        /* Estilo para el título en la cabecera */
        .card-header-custom {
            background-color: #212529; 
            color: white;
            font-weight: bold;
            text-align: center;
            padding: 1rem;
        }

        /* Estilo para los inputs (consistencia visual oscura) */
        .form-control-dark {
            background-color: #343a40; /* Input más oscuro que el fondo de la tarjeta */
            border: 1px solid #495057;
            color: #f8f9fa; /* Texto blanco en el input */
        }
        .form-control-dark:focus {
            background-color: #343a40;
            border-color: #0d6efd; /* Resaltar con azul al hacer foco */
            color: #f8f9fa;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        
        /* Botón de acción principal: Iniciar Sesión (Azul) */
        .btn-principal {
            background-color: #0d6efd; 
            border-color: #0d6efd;
            color: white;
            font-weight: bold;
        }
        .btn-principal:hover {
            background-color: #0b5ed7; 
            border-color: #0a58ca;
            color: white;
        }

        /* Botón de acción secundaria: Salir (Gris) */
        .btn-secundario {
            background-color: #6c757d; 
            border-color: #6c757d;
            color: white; 
            font-weight: bold;
        }
        .btn-secundario:hover {
            background-color: #5c636a; 
            border-color: #565e64;
            color: white;
        }
    </style>
</head>
<body>
    
    <!-- Contenedor principal: Tarjeta de Login -->
    <div class="card login-card text-white rounded-3">
        
        <!-- Título/Cabecera de la Tarjeta (Azul) -->
        <div class="card-header card-header-custom rounded-top-3">
            <h3 class="mb-0">Gestión Hotel</h3>
        </div>
        
        <div class="card-body">
            
            <h5 class="text-center mb-4 text-primary">Inicia Sesión para Acceder al Sistema</h5>

            <form action="#" method="post">
                <!-- Campo Usuario -->
                <div class="mb-3">
                    <label for="usuario" class="form-label">Usuario</label>
                    <input type="text" class="form-control form-control-dark" id="usuario" name="usuario" required>
                </div>

                <!-- Campo Contraseña -->
                <div class="mb-4">
                    <label for="contrasena" class="form-label">Contraseña</label>
                    <input type="password" class="form-control form-control-dark" id="contrasena" name="contrasena" required>
                </div>

                <!-- CONTENEDOR DE BOTONES DE ACCIÓN -->
                <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                    <button type="submit" class="btn btn-principal">Iniciar Sesión</button>
                    <button type="button" class="btn btn-secundario" onclick="window.close();">Salir</button>
                </div>
            </form>
            
        </div>
        
        <!-- Pie de página opcional -->
        <div class="card-footer text-end text-muted py-2 bg-black rounded-bottom-3">
            <small>&copy; Sistema de Gestión</small>
        </div>
    </div>
    
    <!-- JavaScript de BOOTSTRAP -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>