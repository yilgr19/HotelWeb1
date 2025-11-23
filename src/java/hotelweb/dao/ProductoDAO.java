package hotelweb.dao;

import hotelweb.models.Categoria;
import hotelweb.models.Producto;
import hotelweb.util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    // 1. Método para llenar el combo box de categorías
    public List<Categoria> obtenerCategorias() {
        List<Categoria> lista = new ArrayList<>();
        String sql = "SELECT * FROM categorias ORDER BY nombre";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while(rs.next()){
                lista.add(new Categoria(rs.getInt("id_categoria"), rs.getString("nombre")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    // 2. Método actualizado con nuevos campos
    public boolean registrarProducto(Producto p) {
        // Agregamos id_categoria y fecha_vencimiento al SQL
        String sql = "INSERT INTO productos (codigo, nombre, descripcion, id_categoria, precio, impuesto, existencia, fecha_vencimiento) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, p.getCodigo());
            ps.setString(2, p.getNombre());
            ps.setString(3, p.getDescripcion());
            ps.setInt(4, p.getIdCategoria());      // NUEVO
            ps.setDouble(5, p.getPrecio());
            ps.setDouble(6, p.getImpuesto());
            ps.setInt(7, p.getExistencia());
            
            // Si la fecha viene vacía, mandamos NULL a la base de datos
            if (p.getFechaVencimiento() == null || p.getFechaVencimiento().isEmpty()) {
                ps.setNull(8, java.sql.Types.DATE);
            } else {
                ps.setString(8, p.getFechaVencimiento()); // NUEVO
            }
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}