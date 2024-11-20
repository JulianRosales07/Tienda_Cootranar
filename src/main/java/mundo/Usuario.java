import java.sql.Timestamp;

public class Usuario {
    private int cedula;
    private String password;
    private String role;
    private Timestamp createdAt;

    // Constructor con los parámetros necesarios
    public Usuario(int cedula, String password, String role, Timestamp createdAt) {
        this.cedula = cedula;
        this.password = password;
        this.role = role;
        this.createdAt = createdAt;
    }

    // Getters
    public int getCedula() {
        return cedula;
    }

    public String getPassword() {
        return password;
    }

    public String getRole() {
        return role;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    // Setters si es necesario
    public void setCedula(int cedula) {
        this.cedula = cedula;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
