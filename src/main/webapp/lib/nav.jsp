<%-- 
    Document   : nav
    Created on : 1/11/2024, 7:58:06 a.m.
    Author     : julia
--%>
<!-- Barra de navegaci�n -->

<div class="navbar">
    <ul class="navbar-links">
        <li><a href="index.jsp">Inicio</a></li>
        <li><a href="productos.jsp">Productos</a></li>
        <li><a href="ventas.jsp">Ventas</a></li>
        <li><a href="reportes.jsp">Reportes</a></li>
        <% if (session.getAttribute("role") != null) { %>
            <li><a href="logoutServlet">Cerrar sesi�n</a></li>
        <% } else { %>
            <li><a href="login.jsp">Iniciar sesi�n</a></li>
        <% } %>
    </ul>
</div>