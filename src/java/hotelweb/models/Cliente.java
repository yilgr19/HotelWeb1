package hotelweb.models;

public class Cliente {

    // Atributos
    private int idCliente;
    private String cedula;
    private String nombre;
    private String apellido;
    private String telefono;
    private String direccion;
    private String correo;

    // --- CONSTRUCTORES ---
    
    /**
     * Constructor para REGISTRAR (sin ID)
     */
    public Cliente(String cedula, String nombre, String apellido, String telefono, String direccion, String correo) {
        this.cedula = cedula;
        this.nombre = nombre;
        this.apellido = apellido;
        this.telefono = telefono;
        this.direccion = direccion;
        this.correo = correo;
    }
    
    /**
     * Constructor para LEER (con ID)
     */
    public Cliente(int idCliente, String cedula, String nombre, String apellido, String telefono, String direccion, String correo) {
        this.idCliente = idCliente;
        this.cedula = cedula;
        this.nombre = nombre;
        this.apellido = apellido;
        this.telefono = telefono;
        this.direccion = direccion;
        this.correo = correo;
    }
    
    /**
     * Constructor vacío
     */
    public Cliente() {}

    // --- GETTERS Y SETTERS ---
    
    public int getIdCliente() { return idCliente; }
    public void setIdCliente(int idCliente) { this.idCliente = idCliente; }

    public String getCedula() { return cedula; }
    public void setCedula(String cedula) { this.cedula = cedula; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }
}