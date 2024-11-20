/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

        function showForm(form) {
            const signinForm = document.querySelector('.sign-in');
            const signupForm = document.querySelector('.sign-up');
            const signinButton = document.querySelector('.tab-button.active');
            const signupButton = document.querySelector('.tab-button:not(.active)');

            if (form === 'signin') {
                signinForm.classList.add('active');
                signupForm.classList.remove('active');
                signinButton.classList.add('active');
                signupButton.classList.remove('active');
            } else {
                signupForm.classList.add('active');
                signinForm.classList.remove('active');
                signupButton.classList.add('active');
                signinButton.classList.remove('active');
            }
        }

        // Inicializa el formulario activo en carga
        document.addEventListener('DOMContentLoaded', () => {
        showForm('signin'); // Mostrar el formulario de inicio de sesión al cargar
        });