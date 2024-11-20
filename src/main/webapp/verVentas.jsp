<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="mundo.Conexion" %>

<%
    // Obtener el rol del usuario desde la sesión
    String usuarioRol = (String) session.getAttribute("usuarioRol");

    // Comprobación temporal del rol
    out.println("Rol del usuario: " + usuarioRol);

    // Lista para almacenar las compras
    List<String[]> compras = new ArrayList<>();
    try {
        Connection conn = Conexion.getConnection();
        String sql = "SELECT id, producto_nombre, cantidad, fecha FROM compras ORDER BY fecha DESC";
        Statement statement = conn.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String producto = resultSet.getString("producto_nombre");
            int cantidad = resultSet.getInt("cantidad");
            String fecha = resultSet.getString("fecha");

            compras.add(new String[]{String.valueOf(id), producto, String.valueOf(cantidad), fecha});
        }

        resultSet.close();
        statement.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p>Error al cargar las compras: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Compras Registradas</title>
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
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
            color: #333;
        }
        .btn {
            padding: 5px 10px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
        }
.btn-guardar {
    background-color: green;
    color: white;
    padding: 5px 10px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.btn-factura {
    background-color: purple;
    color: white;
    padding: 5px 10px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.btn-guardar:hover, .btn-factura:hover {
    opacity: 0.8;
}

        .btn-ver {
            background-color: blue;
            color: white;
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

<h1 style="text-align: center; margin: 20px; margin-top: 80px;">Compras Registradas</h1>
<table>
    <thead>
        <tr>
            <th>Producto</th>
            <th>Cantidad</th>
            <th>Fecha</th>
            <th>Acción</th>
        </tr>
    </thead>
    <tbody>
        <% 
            for (String[] compra : compras) { 
                String compraId = compra[0];
                String producto = compra[1];
                String cantidad = compra[2];
                String fecha = compra[3];
        %>
        <tr>
            <td><%= producto %></td>
            <td><%= cantidad %></td>
            <td><%= fecha %></td>
            <td>
                <% if ("admin".equals(usuarioRol)) { %>
                    <!-- Formulario para generar la factura -->
                    <form action="generarFacturaServlet" method="get" style="display: inline;">
                        <input type="hidden" name="compraId" value="<%= compraId %>">
                        <button type="submit" class="btn btn-factura">Generar Factura</button>
                    </form>
                <% } else { %>
                    <!-- Formulario para descargar la factura -->
                    <form action="descargarFacturaServlet" method="get">
                        <input type="hidden" name="compraId" value="<%= compraId %>">
                        <button type="submit" class="btn btn-ver">Descargar Factura</button>
                    </form>
                <% } %>
            </td>
        </tr>
        <%} %>
    </tbody>
</table>
</body>
</html>