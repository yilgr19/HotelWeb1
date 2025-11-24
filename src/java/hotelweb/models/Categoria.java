// Ubicación: hotelweb.models.Categoria

package hotelweb.models;

public class Categoria {

    // Los atributos deben coincidir con tu tabla 'categoria' (image_47c3b4.png)
    private int idCategoria;
    private String nombre;
    
    // Constructor vacío
    public Categoria() {}

    // --- Getters y Setters ---

    // Este Getter es crucial para la línea 24 del JSP: <%= c.getIdCategoria() %>
    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    // Este Getter es crucial para la línea 24 del JSP: <%= c.getNombre() %>
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}