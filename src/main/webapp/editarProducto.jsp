<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="mundo.Conexion" %>
<%@ page import="java.io.IOException" %>

<%
    // Obtener los parámetros enviados desde el enlace
    String nombreProducto = request.getParameter("nombre");
    double precioProducto = Double.parseDouble(request.getParameter("precio"));
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Producto</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

<div class="container mx-auto p-8">
    <h1 class="text-3xl font-bold mb-6">Editar Producto</h1>

    <form action="EditarProductoServlet" method="post">
        <div class="mb-4">
            <label for="nombre" class="block text-gray-700 font-medium">Nombre del Producto</label>
            <input type="text" id="nombre" name="nombre" value="<%= nombreProducto %>" readonly class="w-full p-2 border border-gray-300 rounded-md">
        </div>
        <div class="mb-4">
            <label for="precio" class="block text-gray-700 font-medium">Precio del Producto</label>
            <input type="number" id="precio" name="precio" value="<%= precioProducto %>" required class="w-full p-2 border border-gray-300 rounded-md">
        </div>
        <div class="flex items-center justify-between">
            <button type="submit" class="bg-blue-500 text-white py-2 px-6 rounded-md hover:bg-blue-600">Actualizar Producto</button>
            <a href="productos.jsp" class="text-gray-600 hover:text-gray-800">Cancelar</a>
        </div>
    </form>
</div>

</body>
</html>
