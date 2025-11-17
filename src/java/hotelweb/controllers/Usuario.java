package hotelweb.controllers;

public class Usuario {
    
    // Atributos
    private String username;
    private String password; // En un sistema real, esto debería estar encriptado
    private String rol;
    private String nombreCompleto;

    // Constructor (usado en UsuarioManager)
    public Usuario(String username, String password, String rol, String nombreCompleto) {
        this.username = username;
        this.password = password;
        this.rol = rol;
        this.nombreCompleto = nombreCompleto;
    }

    // Getters (necesarios para la lógica)
    public String getUsername() {
        return username;
    }

    public String getRol() {
        return rol;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }
    
    // Método para verificar la contraseña (usado en UsuarioManager)
    public boolean verificarPassword(String passwordIngresada) {
        // Compara la contraseña guardada con la que se ingresó
        return this.password.equals(passwordIngresada);
    }
}