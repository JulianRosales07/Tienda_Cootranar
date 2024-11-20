<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="mundo.Producto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mundo.Conexion" %>

<%
    // Declarar la lista de productos fuera de la comprobación
    List<Producto> productos = new ArrayList<>();  

    // Obtener el rol del usuario
    String role = (String) session.getAttribute("usuarioRol");

    try {
        Connection conn = Conexion.getConnection();
        String sql = "SELECT nombre, precio FROM productos"; 
        Statement statement = conn.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            String nombre = resultSet.getString("nombre");
            double precio = resultSet.getDouble("precio"); 
            productos.add(new Producto(nombre, precio)); 
        }

        resultSet.close();
        statement.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color: red;'>Error al cargar los productos: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
/* Variables globales */
:root {
    --azul-primario: #007bff;
    --azul-oscuro: #0056b3;
    --gris-oscuro: #343a40;
    --amarillo: #ffc107;
    --rojo: #dc3545;
    --blanco: #fff;
    --negro: #151515;
    --tiempo-transicion: 0.3s;
}

/* Estilos generales */
body {
    font-family: 'Roboto', sans-serif;
    background: url('https://i.pinimg.com/736x/a1/15/f5/a115f56a594b1c37a9a5bdf80dd09dbc.jpg') no-repeat center center fixed;
    background-size: cover;
    margin: 0;
    padding: 0;
    color: var(--gris-oscuro);
}

/* Navbar */
.navbar {
    background-color: var(--azul-primario);
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
    transition: background-color var(--tiempo-transicion), box-shadow var(--tiempo-transicion);
}

.navbar:hover {
    background-color: var(--azul-oscuro);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
}

.navbar-links {
    list-style: none;
    margin: 0;
    padding: 0;
    display: flex;
    gap: 20px;
}

.navbar-links a {
    color: var(--blanco);
    text-decoration: none;
    font-weight: 500;
    font-size: 1.1em;
    padding: 8px 15px;
    border-radius: 5px;
    transition: color var(--tiempo-transicion), background-color var(--tiempo-transicion);
}

.navbar-links a:hover {
    color: var(--amarillo);
    background-color: var(--gris-oscuro);
    text-decoration: underline;
}

.navbar-links a.active {
    color: var(--amarillo);
    background-color: var(--gris-oscuro);
    font-style: italic;
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
}

/* Productos */
.products-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
    margin: 20px auto;
}

.product-card {
    background-color: var(--blanco);
    border-radius: 10px;
    width: 250px;
    height: 300px;
    overflow: hidden;
    position: relative;
    perspective: 1000px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    transition: transform var(--tiempo-transicion);
}

.product-card .content {
    position: relative;
    width: 100%;
    height: 100%;
    text-align: center;
    transform-style: preserve-3d;
    transition: transform var(--tiempo-transicion);
}

.product-card:hover .content {
    transform: rotateY(180deg);
}

.product-card .front,
.product-card .back {
    position: absolute;
    width: 100%;
    height: 100%;
    backface-visibility: hidden;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

.product-card .front {
    background-color: var(--azul-primario);
    color: var(--blanco);
}

.product-card .back {
    background-color: var(--gris-oscuro);
    color: var(--blanco);
    transform: rotateY(180deg);
}

.product-card h2 {
    font-size: 1.5em;
}

.product-card p {
    font-size: 1em;
    margin: 10px 0;
}

/* Acciones admin */
.admin-actions a {
    display: inline-block;
    margin: 5px;
    padding: 10px 20px;
    font-size: 0.9em;
    text-decoration: none;
    color: var(--blanco);
    border-radius: 5px;
    transition: background-color var(--tiempo-transicion);
}

.admin-actions .btn-warning {
    background-color: var(--amarillo);
}

.admin-actions .btn-danger {
    background-color: var(--rojo);
}

.admin-actions .btn-warning:hover {
    background-color: darken(var(--amarillo), 10%);
}

.admin-actions .btn-danger:hover {
    background-color: darken(var(--rojo), 10%);
}

/* Accesibilidad */
@media (prefers-reduced-motion: reduce) {
    * {
        animation: none;
        transition: none;
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

<h1>Lista de Productos</h1>
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 px-6 py-8">
    <% for (Producto producto : productos) { %>
        <div class="flex flex-col bg-white rounded-3xl shadow-md">
            <!-- Contenido de la tarjeta -->
            <div class="px-6 py-8 sm:p-10 sm:pb-6">
                <div class="grid items-center justify-center w-full grid-cols-1 text-left">
                    <div>
                        <h2
                            class="text-lg font-medium tracking-tighter text-gray-600 lg:text-3xl"
                        >
                            <%= producto.getNombre() %>
                        </h2>
                        <p class="mt-2 text-sm text-gray-500">
                            Precio del producto.
                        </p>
                    </div>
                    <div class="mt-6">
                        <p>
                            <span class="text-5xl font-light tracking-tight text-black">
                                $<%= String.format("%.2f", producto.getPrecio()) %>
                            </span>
                        </p>
                    </div>
                </div>
            </div>
            
            <!-- Botones para admin o usuario normal -->
            <div class="flex px-6 pb-8 sm:px-8">
                <% if ("admin".equalsIgnoreCase(role)) { %>
                    <!-- Botones para administradores -->
                    <a class="flex items-center justify-center w-full px-6 py-2.5 text-center text-white duration-200 bg-yellow-500 border-2 border-yellow-500 rounded-full hover:bg-transparent hover:border-yellow-500 hover:text-yellow-500 focus:outline-none text-sm" 
                       href="editarProducto.jsp?nombre=<%= producto.getNombre() %>&precio=<%= producto.getPrecio() %>">
                        Editar
                    </a>
                    <a
                        class="flex items-center justify-center w-full px-6 py-2.5 text-center text-white duration-200 bg-red-500 border-2 border-red-500 rounded-full hover:bg-transparent hover:border-red-500 hover:text-red-500 focus:outline-none text-sm ml-2"
                        href="eliminarProducto?nombre=<%= producto.getNombre() %>"
                        onclick="return confirm('¿Estás seguro de que deseas eliminar este producto?');"
                    >
                        Eliminar
                    </a>
                <% } else { %>

                    <!-- Botón para usuarios normales -->
                    <form action="comprarServlet" method="post" class="w-full">
                        <!-- Se pueden incluir valores dinámicos según el producto seleccionado -->
                        <input type="hidden" name="productoNombre" value="<%= producto.getNombre() %>">
                        <input type="hidden" name="cantidad" value="1"> <!-- La cantidad por defecto o dinámica -->

                        <button
                            type="submit"
                            class="flex items-center justify-center w-full px-6 py-2.5 text-center text-white duration-200 bg-black border-2 border-black rounded-full hover:bg-transparent hover:border-black hover:text-black focus:outline-none text-sm"
                        >
                            Comprar
                        </button>
                    </form>

                <% } %>
            </div>
        </div>
    <% } %>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
