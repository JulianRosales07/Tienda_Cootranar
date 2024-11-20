<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mundo.ProductoCarrito" %>

<%
    // Obtener la lista del carrito de compras desde la sesión
    List<ProductoCarrito> carrito = (List<ProductoCarrito>) session.getAttribute("carrito");

    if (carrito == null) {
        carrito = new ArrayList<>();
        session.setAttribute("carrito", carrito);
    }

    // Obtener los parámetros enviados
    String nombre = request.getParameter("nombre");
    int cantidad = Integer.parseInt(request.getParameter("cantidad"));
    double precio = Double.parseDouble(request.getParameter("precio"));

    // Verificar si el producto ya está en el carrito
    boolean encontrado = false;
    for (ProductoCarrito producto : carrito) {
        if (producto.getNombre().equals(nombre)) {
            producto.setCantidad(producto.getCantidad() + cantidad);
            encontrado = true;
            break;
        }
    }

    // Si no está en el carrito, agregarlo
    if (!encontrado) {
        carrito.add(new ProductoCarrito(nombre, cantidad, precio));
    }

    response.sendRedirect("verCarrito.jsp"); // Redirigir a la página del carrito
%>
