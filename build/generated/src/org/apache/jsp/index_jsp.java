package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write('\n');

    if (session.getAttribute("usuarioLogueado") != null) {
        // Si hay una sesión, lo mandamos al dashboard (¡Cámbialo por tu página principal!)
        response.sendRedirect("dashboard.jsp"); 
        return; // Detiene la carga del resto de la página (el formulario de login)
    }

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"es\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <title>Gestión Hotel - Login</title>\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("    \n");
      out.write("    <!-- CSS de BOOTSTRAP (Corregí los atributos 'integrity' y 'crossorigin') -->\n");
      out.write("    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH\" crossorigin=\"anonymous\">\n");
      out.write("    \n");
      out.write("    <style>\n");
      out.write("        /* Estilos base para el fondo oscuro */\n");
      out.write("        body {\n");
      out.write("            /* Fondo oscuro para la consistencia del sistema */\n");
      out.write("            background-color: #343a40; \n");
      out.write("            min-height: 100vh;\n");
      out.write("            /* Centrar el contenido vertical y horizontalmente */\n");
      out.write("            display: flex;\n");
      out.write("            justify-content: center;\n");
      out.write("            align-items: center;\n");
      out.write("            padding: 20px; \n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Estilo para el contenedor del login (tarjeta oscura) */\n");
      out.write("        .login-card {\n");
      out.write("            max-width: 450px; \n");
      out.write("            width: 90%; /* Responsive en móviles */\n");
      out.write("            background-color: #212529; /* Fondo gris oscuro */\n");
      out.write("            border: none;\n");
      out.write("            /* Sombra y esquinas redondeadas */\n");
      out.write("            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Estilo para el título en la cabecera */\n");
      out.write("        .card-header-custom {\n");
      out.write("            background-color: #212529; \n");
      out.write("            color: white;\n");
      out.write("            font-weight: bold;\n");
      out.write("            text-align: center;\n");
      out.write("            padding: 1rem;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Estilo para los inputs (consistencia visual oscura) */\n");
      out.write("        .form-control-dark {\n");
      out.write("            background-color: #343a40; /* Input más oscuro que el fondo de la tarjeta */\n");
      out.write("            border: 1px solid #495057;\n");
      out.write("            color: #f8f9fa; /* Texto blanco en el input */\n");
      out.write("        }\n");
      out.write("        .form-control-dark:focus {\n");
      out.write("            background-color: #343a40;\n");
      out.write("            border-color: #0d6efd; /* Resaltar con azul al hacer foco */\n");
      out.write("            color: #f8f9fa;\n");
      out.write("            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        /* Botón de acción principal: Iniciar Sesión (Azul) */\n");
      out.write("        .btn-principal {\n");
      out.write("            background-color: #0d6efd; \n");
      out.write("            border-color: #0d6efd;\n");
      out.write("            color: white;\n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("        .btn-principal:hover {\n");
      out.write("            background-color: #0b5ed7; \n");
      out.write("            border-color: #0a58ca;\n");
      out.write("            color: white;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Botón de acción secundaria: Salir (Gris) */\n");
      out.write("        .btn-secundario {\n");
      out.write("            background-color: #6c757d; \n");
      out.write("            border-color: #6c757d;\n");
      out.write("            color: white; \n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("        .btn-secundario:hover {\n");
      out.write("            background-color: #5c636a; \n");
      out.write("            border-color: #565e64;\n");
      out.write("            color: white;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    \n");
      out.write("    <!-- Contenedor principal: Tarjeta de Login -->\n");
      out.write("    <div class=\"card login-card text-white rounded-3\">\n");
      out.write("        \n");
      out.write("        <!-- Título/Cabecera de la Tarjeta (Azul) -->\n");
      out.write("        <div class=\"card-header card-header-custom rounded-top-3\">\n");
      out.write("            <h3 class=\"mb-0\">Gestión Hotel</h3>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <div class=\"card-body\">\n");
      out.write("            \n");
      out.write("            <h5 class=\"text-center mb-4 text-primary\">Inicia Sesión para Acceder al Sistema</h5>\n");
      out.write("\n");
      out.write("            ");
      out.write("\n");
      out.write("            ");
 
                String error = (String) request.getAttribute("error");
                if (error != null) {
                    out.println("<div class='alert alert-danger' role='alert'>");
                    out.println(error);
                    out.println("</div>");
                }
            
      out.write("\n");
      out.write("\n");
      out.write("            <!-- \n");
      out.write("                PASO 3: FORMULARIO CORREGIDO\n");
      out.write("                - action=\"LoginServlet\" (Debe coincidir con tu web.xml)\n");
      out.write("                - method=\"POST\"\n");
      out.write("            -->\n");
      out.write("            <form action=\"LoginServlet\" method=\"POST\">\n");
      out.write("                <!-- Campo Usuario -->\n");
      out.write("                <div class=\"mb-3\">\n");
      out.write("                    <label for=\"usuario\" class=\"form-label\">Usuario</label>\n");
      out.write("                    <!-- \n");
      out.write("                       PASO 4: CORRECCIÓN DE 'name'\n");
      out.write("                       (El 'name' debe coincidir con el servlet: \"txtUsuario\") \n");
      out.write("                    -->\n");
      out.write("                    <input type=\"text\" class=\"form-control form-control-dark\" id=\"usuario\" name=\"txtUsuario\" required>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <!-- Campo Contraseña -->\n");
      out.write("                <div class=\"mb-4\">\n");
      out.write("                    <label for=\"contrasena\" class=\"form-label\">Contraseña</label>\n");
      out.write("                    <!-- \n");
      out.write("                       PASO 4: CORRECCIÓN DE 'name'\n");
      out.write("                       (El 'name' debe coincidir con el servlet: \"txtPassword\") \n");
      out.write("                    -->\n");
      out.write("                    <input type=\"password\" class=\"form-control form-control-dark\" id=\"contrasena\" name=\"txtPassword\" required>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <!-- CONTENEDOR DE BOTONES DE ACCIÓN -->\n");
      out.write("                <div class=\"d-grid gap-2 d-md-flex justify-content-md-center\">\n");
      out.write("                    <button type=\"submit\" class=\"btn btn-principal\">Iniciar Sesión</button>\n");
      out.write("                    <button type=\"button\" class=\"btn btn-secundario\" onclick=\"window.close();\">Salir</button>\n");
      out.write("                </div>\n");
      out.write("            </form>\n");
      out.write("            \n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <!-- Pie de página opcional -->\n");
      out.write("        <div class=\"card-footer text-end text-muted py-2 bg-black rounded-bottom-3\">\n");
      out.write("            <small>&copy; Sistema de Gestión</small>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("    \n");
      out.write("    <!-- JavaScript de BOOTSTRAP (Corregí los atributos 'integrity' y 'crossorigin') -->\n");
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
