package hotelweb.controllers;

import java.util.ArrayList; 
import java.util.List;      

public class UsuarioManager { 
    
    // Lista estática: Aquí se guardan los usuarios iniciales en la memoria del servidor.
    private static final List<Usuario> listaUsuarios = new ArrayList<>();

    // Bloque estático: Se ejecuta solo una vez al cargar la aplicación.
    static {
        // Inicialización de los usuarios y sus roles
        listaUsuarios.add(new Usuario("admin", "admin123", "Administrador", "Administrador del Sistema"));
        listaUsuarios.add(new Usuario("recepcion", "recepcion123", "Recepcion", "Recepcionista Principal"));
        listaUsuarios.add(new Usuario("camilo", "camilo123", "Administrador", "Camilo Ramirez"));
        listaUsuarios.add(new Usuario("melanny", "melanny123", "Administrador", "Melanny Guate"));
    }

    /**
     * Busca al usuario e intenta autenticarlo.
     * @param username El nombre de usuario ingresado.
     * @param password La contraseña ingresada.
     * @return El objeto Usuario si las credenciales son válidas, o null.
     */
    public static Usuario autenticarUsuario(String username, String password) {
        for (Usuario usuario : listaUsuarios) {
            if (usuario.getUsername().equals(username) && usuario.verificarPassword(password)) {
                return usuario;
            }
        }
        return null;
    }
    
    // --- Lógica de Roles ---
    
    private static boolean esAdministrador(Usuario usuario) {
        // Los usuarios 'admin', 'camilo' y 'melanny' son Administradores según la inicialización.
        return usuario.getRol().equals("Administrador");
    }
    
    private static boolean esRecepcionista(Usuario usuario) {
        return usuario.getRol().equals("Recepcion");
    }

    /**
     * Verifica si el usuario tiene permiso para una acción específica.
     * @param usuario El objeto Usuario (obtenido de la sesión HTTP).
     * @param permiso El código de permiso (ej. "NUEVA_VENTA").
     * @return true si tiene permiso.
     */
    public static boolean tienePermiso(Usuario usuario, String permiso) {
        if (usuario == null) return false;
        
        // Regla 1: Si es Administrador (incluyendo camilo y melanny), tiene acceso a todo.
        if (esAdministrador(usuario)) return true;
        
        // Regla 2: Permisos específicos para Recepción.
        switch (permiso) {
            case "GESTION_HABITACIONES":
            case "GESTION_USUARIOS":
            case "REPORTES":
                return false; // Solo Administrador (ya cubierto arriba)
                
            case "CHECKIN_CHECKOUT":
            case "RESERVAS":
            case "NUEVA_VENTA":
            case "REGISTRAR_PRODUCTOS": 
                return esRecepcionista(usuario); 
                
            default:
                return false;
        }
    }
}