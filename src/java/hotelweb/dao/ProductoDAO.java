// Ubicación: hotelweb.dao.ProductoDAO

package hotelweb.dao;

import hotelweb.models.Categoria;
import hotelweb.models.Producto; // Importamos Producto para el nuevo método
import hotelweb.util.ConexionBD; // << Revisa que esta ruta sea correcta
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {
    
    // ===================================================================
    // MÉTODO 1: GUARDAR PRODUCTO (FALTABA EN EL CÓDIGO ANTERIOR)
    // ===================================================================
    public boolean guardarProducto(Producto producto) {
        // La consulta INSERT debe coincidir con las columnas de tu tabla 'producto'
        // CÓDIGO CORREGIDO:
        String sql = "INSERT INTO productos (codigo, nombre, descripcion, id_categoria, precio, impuesto, existencia, fecha_vencimiento) " +
             "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        Connection con = null;
        PreparedStatement ps = null;
        boolean guardado = false;

        try {
            con = ConexionBD.getConnection(); 
            ps = con.prepareStatement(sql);
            
            // Asignar parámetros
            ps.setString(1, producto.getCodigo());
            ps.setString(2, producto.getNombre());
            ps.setString(3, producto.getDescripcion());
            ps.setInt(4, producto.getIdCategoria());
            ps.setDouble(5, producto.getPrecio());
            ps.setDouble(6, producto.getImpuesto());
            ps.setInt(7, producto.getExistencia());
            
            // Manejar la fecha opcional (puede ser NULL)
            if (producto.getFechaVencimiento() != null) {
                ps.setDate(8, producto.getFechaVencimiento());
            } else {
                ps.setNull(8, java.sql.Types.DATE); 
            }

            int filasAfectadas = ps.executeUpdate();

            if (filasAfectadas > 0) {
                guardado = true;
            }
            
        } catch (SQLException e) {
            System.err.println("--- ERROR AL GUARDAR PRODUCTO ---");
            System.err.println("Mensaje: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Cierre seguro de recursos
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.err.println("Error al cerrar recursos: " + ex.getMessage());
            }
        }
        return guardado;
    }

    // ===================================================================
    // MÉTODO 2: OBTENER CATEGORÍAS (CORRECCIÓN A 'categorias')
    // ===================================================================
    public List<Categoria> obtenerCategorias() {
        List<Categoria> lista = new ArrayList<>();
        
        // --- CORRECCIÓN APLICADA: 'categoria' se cambió a 'categorias' ---
        String sql = "SELECT id_categoria, nombre FROM categorias ORDER BY nombre"; 
        // -------------------------------------------------------------------
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        System.out.println("--- INTENTANDO CARGAR CATEGORÍAS ---");
        
        try {
            con = ConexionBD.getConnection(); 
            System.out.println("Conexión obtenida correctamente.");
            
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            int contador = 0;
            while (rs.next()) {
                Categoria c = new Categoria();
                c.setIdCategoria(rs.getInt("id_categoria"));
                c.setNombre(rs.getString("nombre"));
                lista.add(c);
                contador++;
            }
            
            System.out.println("Categorías cargadas: " + contador);
            
        } catch (SQLException e) {
            System.err.println("--- ERROR CRÍTICO AL OBTENER CATEGORÍAS ---");
            System.err.println("Mensaje de Error SQL: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Cierre seguro de recursos
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.err.println("Error al cerrar recursos: " + ex.getMessage());
            }
        }
        return lista;
    }
}