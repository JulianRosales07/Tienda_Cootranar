<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="lib/header.jsp" %>
<link rel="stylesheet" type="text/css" href="Estilos/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.0.5/css/boxicons.min.css"> 
<div class="main-container"> 
    <div class="tabs">
        <button class="tab-button active" onclick="showForm('signin')">Iniciar Sesión</button>
        <button class="tab-button" onclick="showForm('signup')">Registrarse</button>
    </div>

    <!-- Formulario de Iniciar Sesión -->
    <div class="container-form sign-in active">
        <form class="formulario" method="post" action="loginServlet">
            <h2 class="create-account">Iniciar Sesión</h2>
            <label for="signin-cedula">Cédula</label>
            <input type="number" id="signin-cedula" name="cedula" placeholder="Cédula" required aria-label="Cédula de inicio de sesión">

            <label for="signin-password">Contraseña</label>
            <input type="password" id="signin-password" name="password" placeholder="Contraseña" required aria-label="Contraseña de inicio de sesión">

            <input type="submit" value="Iniciar Sesión">
        </form>
    </div>

    <!-- Formulario de Registro -->
    <div class="container-form sign-up">
        <form class="formulario" method="post" action="registerServlet">
            <h2 class="create-account">Crear una cuenta</h2>

            <!-- Mostrar mensaje de error si existe -->
            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>

            <label for="signup-cedula">Cédula</label>
            <input type="number" id="signup-cedula" name="cedula" placeholder="Cédula" required aria-label="Cédula para el registro">

            <label for="signup-password">Contraseña</label>
            <input type="password" id="signup-password" name="password" placeholder="Contraseña" required minlength="8">

            <!-- Campo para seleccionar el rol -->
            <label for="signup-role">Rol</label>
            <select id="signup-role" name="role_id" required>
                <option value="" disabled selected>Seleccione un rol</option>
                <option value="1">ADMIN</option>
                <option value="2">USER</option>
            </select>

            <input type="submit" value="Registrarse">
        </form>
    </div>
</div>

<script src="scripts/script.js" defer></script>
<%@ include file="lib/footer.jsp" %>
