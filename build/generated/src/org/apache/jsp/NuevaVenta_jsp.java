package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class NuevaVenta_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"es\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <title>Registra Nueva Venta (Sistema de Ventas)</title>\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js\" xintegrity=\"sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz\" crossorigin=\"anonymous\"></script>\n");
      out.write("    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\" xintegrity=\"sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH\" crossorigin=\"anonymous\">\n");
      out.write("    \n");
      out.write("    <style>\n");
      out.write("        /* Estilos base para centrar el formulario y usar tema oscuro */\n");
      out.write("        body {\n");
      out.write("            background-color: #343a40;\n");
      out.write("            min-height: 100vh;\n");
      out.write("            display: flex;\n");
      out.write("            justify-content: center;\n");
      out.write("            align-items: center;\n");
      out.write("            font-family: 'Inter', sans-serif;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .form-dark-card {\n");
      out.write("            /* AUMENTO DEL ANCHO: de 800px a 1000px para evitar scroll y usar más espacio */\n");
      out.write("            max-width: 1000px; \n");
      out.write("            width: 95%; /* Usar un 95% del ancho de la pantalla */\n");
      out.write("            background-color: #212529; /* Dark background */\n");
      out.write("            border-radius: 1rem;\n");
      out.write("            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5);\n");
      out.write("            color: #f8f9fa;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .card-header {\n");
      out.write("            background-color: #212529; /* Primary blue header for visibility */\n");
      out.write("            border-top-left-radius: 1rem;\n");
      out.write("            border-top-right-radius: 1rem;\n");
      out.write("            color: white;\n");
      out.write("            padding: 1rem 0;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .form-control, .form-select {\n");
      out.write("            background-color: #495057; \n");
      out.write("            color: #fff; \n");
      out.write("            border: 1px solid #6c757d;\n");
      out.write("            border-radius: 0.5rem;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .form-control:focus, .form-select:focus {\n");
      out.write("            background-color: #495057;\n");
      out.write("            color: #fff;\n");
      out.write("            border-color: #0d6efd; \n");
      out.write("            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .form-label {\n");
      out.write("            font-weight: bold;\n");
      out.write("            color: #adb5bd;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        /* BOTONES: Aseguramos un ancho mínimo para que sean legibles */\n");
      out.write("        .btn-responsive {\n");
      out.write("            flex-grow: 1; /* Permite que los botones crezcan y ocupen el espacio disponible */\n");
      out.write("            max-width: 150px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .read-only-field {\n");
      out.write("            background-color: #343a40 !important; /* Más oscuro para indicar que es de solo lectura */\n");
      out.write("            border-color: #495057 !important;\n");
      out.write("            color: #fff !important;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        /* Estilos para el título de la sección de totales */\n");
      out.write("        .section-title {\n");
      out.write("            color: #0d6efd;\n");
      out.write("            border-bottom: 2px solid white;\n");
      out.write("            padding-bottom: 0.5rem;\n");
      out.write("            margin-top: 1rem;\n");
      out.write("            margin-bottom: 1rem;\n");
      out.write("            font-size: 1.25rem;\n");
      out.write("            font-weight: 600;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    \n");
      out.write("    <div class=\"card form-dark-card\">\n");
      out.write("        \n");
      out.write("         <div class=\"card-header bg-black text-center py-3 rounded-top-3\">\n");
      out.write("            <h2 class=\"mb-0\">Nueva Venta</h2>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <div class=\"card-body\">\n");
      out.write("            <form id=\"ventaForm\" action=\"VentaServlet\" method=\"post\">\n");
      out.write("                <input type=\"hidden\" name=\"id\" value=\"0\"> <!-- ID de Venta, lo gestiona el backend -->\n");
      out.write("                \n");
      out.write("                <div class=\"row g-4\">\n");
      out.write("                    \n");
      out.write("                    <!-- Columna Izquierda: Datos del Cliente, Producto y Pago (Ocupa más espacio en pantallas grandes) -->\n");
      out.write("                    <div class=\"col-lg-8\">\n");
      out.write("                        \n");
      out.write("                        <div class=\"section-title text-white\">Datos del Cliente</div>\n");
      out.write("\n");
      out.write("                        <div class=\"row g-3 mb-4\">\n");
      out.write("                            <!-- Cédula del Cliente -->\n");
      out.write("                            <div class=\"col-md-6\">\n");
      out.write("                                <label for=\"cedulaCliente\" class=\"form-label text-white\">Cédula del Cliente:</label>\n");
      out.write("                                <div class=\"input-group\">\n");
      out.write("                                    <input type=\"text\" class=\"form-control\" id=\"cedulaCliente\" name=\"cedulaCliente\" required>\n");
      out.write("                                    <button class=\"btn btn-primary\" type=\"button\" id=\"btnBuscarCliente\" onclick=\"buscarCliente()\">Buscar Cliente</button>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                            \n");
      out.write("                            <!-- Nombre del Cliente (Sólo lectura) -->\n");
      out.write("                            <div class=\"col-md-6\">\n");
      out.write("                                <label for=\"nombreCliente\" class=\"form-label text-white\">Nombre del Cliente:</label>\n");
      out.write("                                <input type=\"text\" class=\"form-control read-only-field\" id=\"nombreCliente\" value=\"Pendiente de búsqueda\" readonly>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"section-title text-white\">Detalle del Producto</div>\n");
      out.write("\n");
      out.write("                        <div class=\"row g-3 mb-4\">\n");
      out.write("                            <!-- ID/Código del Producto -->\n");
      out.write("                            <div class=\"col-md-6\">\n");
      out.write("                                <label for=\"codigoProducto\" class=\"form-label text-white\">Código del Producto:</label>\n");
      out.write("                                <div class=\"input-group\">\n");
      out.write("                                    <input type=\"text\" class=\"form-control\" id=\"codigoProducto\" name=\"codigoProducto\" required>\n");
      out.write("                                    <button class=\"btn btn-primary\" type=\"button\" id=\"btnBuscarProducto\" onclick=\"buscarProducto()\">Buscar Producto</button>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("                            <div class=\"col-md-6\">\n");
      out.write("                                <label for=\"cantidad\" class=\"form-label text-white\">Cantidad:</label>\n");
      out.write("                                <input type=\"number\" class=\"form-control\" id=\"cantidad\" name=\"cantidad\" value=\"1\" min=\"1\" required onchange=\"calcularTotales()\">\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("                            <div class=\"col-md-6\">\n");
      out.write("                                <label for=\"descripcion\" class=\"form-label text-white\">Descripción:</label>\n");
      out.write("                                <input type=\"text\" class=\"form-control read-only-field\" id=\"descripcion\" readonly>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"col-md-6\">\n");
      out.write("                                <label for=\"precioVenta\" class=\"form-label text-white\">Precio Unitario:</label>\n");
      out.write("                                <input type=\"text\" class=\"form-control read-only-field\" id=\"precioVenta\" readonly>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"col-md-6\">\n");
      out.write("                                <label for=\"ivaProducto\" class=\"form-label text-white\">Tasa IVA Aplicada:</label>\n");
      out.write("                                <input type=\"text\" class=\"form-control read-only-field\" id=\"ivaProducto\" readonly>\n");
      out.write("                                <input type=\"hidden\" id=\"ivaPorcentaje\" value=\"0\"> <!-- Almacena el % del IVA -->\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <!-- Información de Pago -->\n");
      out.write("                        <div class=\"section-title text-white\">Información de Pago</div>\n");
      out.write("                        <div class=\"row g-3 mb-4\">\n");
      out.write("                            <div class=\"col-md-6\">\n");
      out.write("                                <label for=\"tipoPago\" class=\"form-label\">Tipo de Pago:</label>\n");
      out.write("                                <select class=\"form-select\" id=\"tipoPago\" name=\"tipoPago\" required>\n");
      out.write("                                    <option value=\"\" selected disabled>Seleccione...</option>\n");
      out.write("                                    <option value=\"EFECTIVO\">Efectivo</option>\n");
      out.write("                                    <option value=\"TARJETA\">Tarjeta</option>\n");
      out.write("                                    <option value=\"TRANSFERENCIA\">Transferencia</option>\n");
      out.write("                                </select>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"col-md-6\">\n");
      out.write("                                <label for=\"fecha\" class=\"form-label text-white\">Fecha (Automática):</label>\n");
      out.write("                                <input type=\"text\" class=\"form-control read-only-field\" id=\"fecha\" value=\"Fecha/Hora de Registro\" readonly>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <!-- BOTONES AHORA EN FILA ABAJO DE LOS CAMPOS PRINCIPALES -->\n");
      out.write("                        <div class=\"section-title text-white\">Acciones</div>\n");
      out.write("                        <div class=\"d-flex justify-content-center gap-3 mb-4 flex-wrap\">\n");
      out.write("                            <button type=\"submit\" name=\"accion\" value=\"guardar\" class=\"btn btn-primary btn-responsive\" id=\"btnRegistrarVenta\" disabled>Registrar</button>\n");
      out.write("                            <button type=\"button\" name=\"accion\" value=\"consultar\" class=\"btn btn-secondary btn-responsive\">Consultar</button>\n");
      out.write("                            <button type=\"button\" name=\"accion\" value=\"limpiar\" class=\"btn btn-secondary btn-responsive\" onclick=\"window.location.reload();\">Nuevo</button>\n");
      out.write("                            <button type=\"button\" onclick=\"window.location.href='Menu.jsp';\" class=\"btn btn-info btn-responsive\">Regresar</button>\n");
      out.write("                        </div>\n");
      out.write("                    </div> <!-- Fin Columna Izquierda -->\n");
      out.write("\n");
      out.write("                    <!-- Columna Derecha: Totales (Mantiene su posición para destacar los valores) -->\n");
      out.write("                    <div class=\"col-lg-4\">\n");
      out.write("                        <div class=\"section-title text-center text-white\">Totales de Venta</div>\n");
      out.write("                        \n");
      out.write("                        <div class=\"d-grid gap-2 mb-4\">\n");
      out.write("                            <label for=\"total\" class=\"form-label\">Total Venta:</label>\n");
      out.write("                            <input type=\"text\" class=\"form-control read-only-field text-center fs-3 py-3\" id=\"total\" name=\"total\" value=\"0.00\" readonly>\n");
      out.write("                            \n");
      out.write("                            <label for=\"subtotal\" class=\"form-label mt-3\">Subtotal Base:</label>\n");
      out.write("                            <input type=\"text\" class=\"form-control read-only-field text-center\" id=\"subtotal\" value=\"0.00\" readonly>\n");
      out.write("                            \n");
      out.write("                            <label for=\"ivaTotal\" class=\"form-label mt-2\">Valor Total IVA:</label>\n");
      out.write("                            <input type=\"text\" class=\"form-control read-only-field text-center\" id=\"ivaTotal\" value=\"0.00\" readonly>\n");
      out.write("                            \n");
      out.write("                            <!-- Campos ocultos para enviar los valores correctos al backend según tu estructura de tabla -->\n");
      out.write("                            <input type=\"hidden\" name=\"iva5\" id=\"iva5\" value=\"0.00\">\n");
      out.write("                            <input type=\"hidden\" name=\"iva19\" id=\"iva19\" value=\"0.00\">\n");
      out.write("                            <input type=\"hidden\" name=\"exento\" id=\"exento\" value=\"0.00\">\n");
      out.write("                        </div>\n");
      out.write("                    </div> <!-- Fin Columna Derecha -->\n");
      out.write("                </div>\n");
      out.write("            </form>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("    \n");
      out.write(" \n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
