<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestión Hotelera</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            background-color: #343a40;
        }

        /* ESTILO PERSONALIZADO PARA EL CARRUSEL */
        .carrusel-bordeado {
            /* Aplica un borde sólido de 3px, color blanco */
         
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.2); 
            /* Asegura que el borde redondeado de Bootstrap funcione correctamente */
            overflow: hidden; 
        }

        /* Estilo para que el carrusel ocupe la mayor parte del espacio en blanco */
        .carrusel-container {
            padding: 20px;
            min-height: calc(100vh - 56px);  
            display: flex;
            align-items: center; /* Centrar verticalmente el carrusel */
            background-color: #343a40;
        }
        .carousel-item img {
            /* Asegura que las imágenes ocupen todo el ancho y alto del carrusel */
            height: 500px;  
            object-fit: cover; /* Recorta la imagen para cubrir el espacio sin distorsionar */
        }
    </style>
</head>
<body>

    <!-- NAVBAR VUELVE A SU ESTADO ORIGINAL -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">GESTION HOTEL</a> 
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Archivo</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Cliente</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Reservas</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Habitacion</a>
                      </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Productos</a>
                        </li>
                   
                  
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="container carrusel-container">

        <!-- APLICAMOS LA CLASE PERSONALIZADA carrusel-bordeado Y EL REDONDEADO DE BOOTSTRAP rounded-3 -->
        <div id="carouselExampleIndicators" class="carousel slide w-100 rounded-3 carrusel-bordeado" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="https://picsum.photos/id/237/1000/500" class="d-block w-100" alt="Habitación 1">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Habitaciones de Lujo</h5>
                        <p>Las mejores comodidades para su estancia.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="https://picsum.photos/id/160/1000/500" class="d-block w-100" alt="Piscina">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Área de Piscina</h5>
                        <p>Relájese bajo el sol.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="https://picsum.photos/id/10/1000/500" class="d-block w-100" alt="Restaurante">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Restaurante Gourmet</h5>
                        <p>Pruebe nuestra cocina de autor.</p>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>