package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class NuevoCliente_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("    <title>Registra Nuevo Cliente (Bootstrap Dark - Columna)</title>\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH\" crossorigin=\"anonymous\">\n");
      out.write("    \n");
      out.write("    <style>\n");
      out.write("        /* Estilos base para centrar el formulario en la página */\n");
      out.write("        body {\n");
      out.write("            background-color: #343a40;\n");
      out.write("            min-height: 100vh;\n");
      out.write("            display: flex;\n");
      out.write("            justify-content: center;\n");
      out.write("            align-items: center;\n");
      out.write("        }\n");
      out.write("        /* Después (con la imagen de fondo): */\n");
      out.write("body {\n");
      out.write("    /* 1. Imagen de Fondo: **REEMPLAZA LA RUTA DE LA IMAGEN AQUÍ** */\n");
      out.write("    background-image: url('C:\\Users\\yilgr\\OneDrive\\Desktop\\hotel fotos'); \n");
      out.write("    \n");
      out.write("    /* 2. Propiedades para cubrir toda la pantalla */\n");
      out.write("    background-size: cover;       /* Ajusta la imagen para cubrir todo el cuerpo */\n");
      out.write("    background-repeat: no-repeat; /* Evita que la imagen se repita */\n");
      out.write("    background-attachment: fixed; /* Mantiene la imagen fija al hacer scroll */\n");
      out.write("    background-position: center center; /* Centra la imagen */\n");
      out.write("    \n");
      out.write("    /* Mantener las propiedades de centrado del formulario */\n");
      out.write("    min-height: 100vh;\n");
      out.write("    display: flex;\n");
      out.write("    justify-content: center;\n");
      out.write("    align-items: center;\n");
      out.write("}\n");
      out.write("\n");
      out.write("        /* Estilo para el contenedor del formulario que lo hace oscuro como el Navbar */\n");
      out.write("        .form-dark-card {\n");
      out.write("            max-width: 650px; \n");
      out.write("            width: 90%;\n");
      out.write("            background-color: #212529; \n");
      out.write("            border: none;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Estilo para los inputs para que contrasten mejor */\n");
      out.write("        .form-control, .form-select {\n");
      out.write("            background-color: #495057; \n");
      out.write("            color: #fff; \n");
      out.write("            border-color: #6c757d;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .form-control:focus {\n");
      out.write("            background-color: #495057;\n");
      out.write("            color: #fff;\n");
      out.write("            border-color: #0d6efd; \n");
      out.write("            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        /* Ajuste para que los botones sean más anchos */\n");
      out.write("        .btn-custom-width {\n");
      out.write("            width: 100px;\n");
      out.write("            height: 40px;/* Ancho fijo como en tu CSS original */\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        /* Ajuste para la columna de botones en pantallas grandes (Lg) */\n");
      out.write("        @media (min-width: 992px) {\n");
      out.write("            .botones-col {\n");
      out.write("                /* Pequeño ajuste de padding para alinear con el primer campo */\n");
      out.write("                padding-top: 1.25rem !important; \n");
      out.write("                /* Centrar la rejilla (d-grid) dentro de la columna */\n");
      out.write("                justify-self: center; \n");
      out.write("            }\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    \n");
      out.write("    <div class=\"card form-dark-card text-white shadow-lg\">\n");
      out.write("        \n");
      out.write("        <div class=\"card-header bg-black text-center py-3\">\n");
      out.write("            <h2 class=\"mb-0\">Registra Cliente</h2>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <div class=\"card-body\">\n");
      out.write("            <form action=\"ClienteServlet\" method=\"post\">\n");
      out.write("                \n");
      out.write("                <div class=\"row g-3\">\n");
      out.write("                    \n");
      out.write("                    <div class=\"col-lg-8\">\n");
      out.write("                        \n");
      out.write("                        <div class=\"mb-3\">\n");
      out.write("                            <label for=\"cedula\" class=\"form-label fw-bold\">Cedula:</label>\n");
      out.write("                            <input type=\"text\" class=\"form-control\" id=\"cedula\" name=\"cedula\" required>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"mb-3\">\n");
      out.write("                            <label for=\"nombre\" class=\"form-label fw-bold\">Nombre:</label>\n");
      out.write("                            <input type=\"text\" class=\"form-control\" id=\"nombre\" name=\"nombre\" required>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"mb-3\">\n");
      out.write("                            <label for=\"apellido\" class=\"form-label fw-bold\">Apellido:</label>\n");
      out.write("                            <input type=\"text\" class=\"form-control\" id=\"apellido\" name=\"apellido\" required>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"mb-3\">\n");
      out.write("                            <label for=\"telefono\" class=\"form-label fw-bold\">Telefono:</label>\n");
      out.write("                            <input type=\"tel\" class=\"form-control\" id=\"telefono\" name=\"telefono\">\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"mb-3\">\n");
      out.write("                            <label for=\"direccion\" class=\"form-label fw-bold\">Direccion:</label>\n");
      out.write("                            <input type=\"text\" class=\"form-control\" id=\"direccion\" name=\"direccion\">\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"mb-3\">\n");
      out.write("                            <label for=\"correo\" class=\"form-label fw-bold\">Correo:</label>\n");
      out.write("                            <input type=\"email\" class=\"form-control\" id=\"correo\" name=\"correo\">\n");
      out.write("                        </div>\n");
      out.write("                        \n");
      out.write("                    </div>\n");
      out.write("                    \n");
      out.write("                    <div class=\"col-lg-4 botones-col\">\n");
      out.write("                        <div class=\"d-grid gap-2 mx-auto\"> \n");
      out.write("                            <button type=\"submit\" name=\"accion\" value=\"guardar\" class=\"btn btn-primary btn-custom-width\">Guardar</button>\n");
      out.write("                            <button type=\"submit\" name=\"accion\" value=\"eliminar\" class=\"btn btn-secondary btn-custom-width\">Eliminar</button>\n");
      out.write("                            <button type=\"submit\" name=\"accion\" value=\"buscar\" class=\"btn btn-secondary btn-custom-width\">Buscar</button>\n");
      out.write("                            <button type=\"button\" onclick=\"window.location.reload();\" class=\"btn btn-secondary btn-custom-width\">Nuevo</button>\n");
      out.write("                            \n");
      out.write("                                 <!-- NUEVO BOTÓN DE REGRESO AL MENÚ -->\n");
      out.write("                            <button type=\"button\" onclick=\"window.location.href='Menu.jsp';\" class=\"btn btn-secondary btn-custom-width\">Regresar</button>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </form>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("    \n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js\" integrity=\"sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz\" crossorigin=\"anonymous\"></script>\n");
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
