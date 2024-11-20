<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%
    // Obtener el rol de la sesión
    String role = (String) session.getAttribute("role");
    if (role == null) {
        role = "GUEST"; // Valor por defecto para usuarios no autenticados
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inicio</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
        <style>
/* Estilos personalizados (excepto navbar) */
body {
    font-family: 'Roboto', sans-serif;
    background: url('https://i.pinimg.com/736x/a1/15/f5/a115f56a594b1c37a9a5bdf80dd09dbc.jpg') no-repeat center center fixed;
    background-size: cover;
    margin: 0;
    padding: 0;
    color: var(--gris-oscuro);
}
h1 {
    text-align: center;
    margin-top: 80px;
    font-size: 3em;
    color: #212529;
    font-weight: 700;
    animation: fadeInDown 1.5s ease-in-out;
    text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1); /* Sutil efecto de sombra */
}

.carousel {
    margin: 30px auto;
    border-radius: 12px;
    overflow: hidden; /* Oculta el contenido que sobresale */
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2); /* Sombra para mayor profundidad */
    max-width: 90%; /* Ancho máximo para evitar que se extienda demasiado */
}

.carousel-item img {
    height: 400px;
    object-fit: cover;
}

.carousel-caption {
    background: rgba(0, 0, 0, 0.6); /* Fondo oscuro semitransparente */
    border-radius: 8px;
    padding: 15px 20px;
    font-size: 1.2em;
    max-width: 70%; /* Limita el ancho de las leyendas */
    margin: 0 auto; /* Centra el contenido */
}

.carousel-caption h5 {
    font-size: 1.8em;
    font-weight: bold;
    color: #ffc107;
}

.carousel-caption p {
    font-size: 1.1em;
    color: #ffffff;
}

.info-section {
    padding: 50px 30px;
    text-align: center;
    background: linear-gradient(135deg, #ffffff, #eef2f7); /* Gradiente claro */
    border-radius: 12px;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
    margin: 40px auto;
    max-width: 80%;
}

.info-section h2 {
    color: #212529;
    margin-bottom: 20px;
    font-size: 2.5em;
    font-weight: bold;
    text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.1);
}

.info-section p {
    font-size: 1.2em;
    line-height: 1.6;
    color: #495057;
}

            .navbar {
                background-color: #007bff; /* Azul Bootstrap */
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                padding: 10px 20px;
                z-index: 1000;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                transition: background-color 0.3s ease, box-shadow 0.3s ease;
            }

            .navbar:hover {
                background-color: #0056b3; /* Azul oscuro */
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
            }

            .navbar-links {
                list-style: none;
                margin: 0;
                padding: 0;
                display: flex;
                gap: 20px;
            }

            .navbar-links li {
                display: inline;
            }

            .navbar-links a {
                color: #f8f9fa;
                text-decoration: none;
                font-weight: 500;
                font-size: 1.1em;
                padding: 8px 15px;
                border-radius: 5px;
                transition: color 0.3s ease, background-color 0.3s ease;
            }

            .navbar-links a:hover {
                color: #ffc107;
                background-color: #495057;
                text-decoration: underline;
            }

            .navbar-links a.active {
                color: #ffc107;
                background-color: #343a40;
                font-style: italic;
            }

            .navbar-right {
                margin-left: auto;
            }

            @media (max-width: 768px) {
                .navbar {
                    flex-direction: column;
                    padding: 15px;
                }

                .navbar-links {
                    flex-direction: column;
                    gap: 10px;
                }

                .navbar-right {
                    margin-left: 0;
                    margin-top: 10px;
                }
            }

            .carousel-caption {
                background: rgba(0, 0, 0, 0.5);
                border-radius: 5px;
                padding: 10px 20px;
                font-size: 1.1em;
            }

            .carousel-caption h5 {
                font-size: 1.5em;
                font-weight: bold;
                color: #ffc107;
            }

            .carousel-caption p {
                font-size: 1em;
                color: #f8f9fa;
            }

/* Animaciones */
@keyframes fadeInDown {
    from {
        opacity: 0;
        transform: translateY(-30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateX(-100px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

        </style>
    </head>
    <body>
<div class="navbar">
    <!-- Enlaces de la izquierda -->
    <ul class="navbar-links">
        <li><a href="Inicio.jsp">Inicio</a></li>
        <li><a href="productos.jsp">Productos</a></li>
        <li><a href="verVentas.jsp">Ventas</a></li>
        <li><a href="cambiarRol.jsp">Gestionar Usuarios</a></li> <!-- Cambiado -->
    </ul>

    <!-- Enlace de Cerrar Sesión a la derecha -->
    <ul class="navbar-links navbar-right">
        <li><a href="logoutServlet">Cerrar sesión</a></li>
    </ul>
</div>
        <!-- Título -->
        <h1>Bienvenido a nuestra Estación</h1>

        <!-- Carrusel de imágenes -->
        <div id="productCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="images/estacion.jpg" class="d-block w-100" alt="Producto 1">
                    <div class="carousel-caption">
                        <h5>Gasolina Regular</h5>
                        <p>¡Calidad garantizada para tu vehículo!</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="images/aceite.avif" class="d-block w-100" alt="Producto 2">
                    <div class="carousel-caption">
                        <h5>Aceite Vehicular</h5>
                        <p>El mejor rendimiento para tu motor.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="images/aditivo.jpg" class="d-block w-100" alt="Producto 3">
                    <div class="carousel-caption">
                        <h5>Aditivos Diesel</h5>
                        <p>Protección total para tu vehículo pesado.</p>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>

        <!-- Sección de información -->
        <div class="info-section">
            <h2>Productos en Venta</h2>
            <p>Encuentra los mejores productos para el cuidado de tu vehículo.</p>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
