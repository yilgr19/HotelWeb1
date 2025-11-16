package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class ConsultarCheckin_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("    <title>Consulta de Check-ins</title>\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("    <!-- CSS de BOOTSTRAP -->\n");
      out.write("    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\" xintegrity=\"sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH\" crossorigin=\"anonymous\">\n");
      out.write("    \n");
      out.write("    <style>\n");
      out.write("        /* Estilos base */\n");
      out.write("        body {\n");
      out.write("            /* Fondo oscuro para la consistencia del sistema */\n");
      out.write("            background-color: #343a40; \n");
      out.write("            min-height: 100vh;\n");
      out.write("            display: flex;\n");
      out.write("            justify-content: center;\n");
      out.write("            align-items: flex-start;\n");
      out.write("            padding: 20px 0; \n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Estilo para el contenedor principal de la consulta (tarjeta oscura) */\n");
      out.write("        .consulta-dark-card {\n");
      out.write("            max-width: 95%; \n");
      out.write("            width: 1300px; \n");
      out.write("            background-color: #212529; \n");
      out.write("            border: none;\n");
      out.write("            min-height: 85vh; \n");
      out.write("            display: flex;\n");
      out.write("            flex-direction: column;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Estilo para los inputs, select y botones (consistencia visual) */\n");
      out.write("        .btn-custom {\n");
      out.write("            width: 150px; \n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Botón de acción principal: Actualizar (Azul) */\n");
      out.write("        .btn-principal {\n");
      out.write("            background-color: #0d6efd; \n");
      out.write("            border-color: #0d6efd;\n");
      out.write("            color: white;\n");
      out.write("        }\n");
      out.write("        .btn-principal:hover {\n");
      out.write("            background-color: #0b5ed7; \n");
      out.write("            border-color: #0a58ca;\n");
      out.write("            color: white;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Botón de acción secundaria: Mostrar Todas / Regresar (Gris) */\n");
      out.write("        .btn-secundario {\n");
      out.write("            background-color: #6c757d; \n");
      out.write("            border-color: #6c757d;\n");
      out.write("            color: white; \n");
      out.write("        }\n");
      out.write("        .btn-secundario:hover {\n");
      out.write("            background-color: #5c636a; \n");
      out.write("            border-color: #565e64;\n");
      out.write("            color: white;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        /* Botón de Check-out/Finalizar (Rojo) */\n");
      out.write("        .btn-finalizar {\n");
      out.write("            background-color: #dc3545; /* Rojo de Bootstrap Danger */\n");
      out.write("            border-color: #dc3545;\n");
      out.write("            color: white;\n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("        .btn-finalizar:hover {\n");
      out.write("            background-color: #c82333; \n");
      out.write("            border-color: #bd2130;\n");
      out.write("            color: white;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Estilo para la tabla oscura (Bootstrap Dark Table) */\n");
      out.write("        .table-dark-custom {\n");
      out.write("            --bs-table-bg: #212529; /* Fondo de tabla oscuro */\n");
      out.write("            --bs-table-color: #f8f9fa; /* Texto CLARO (blanco) por defecto para toda la tabla */\n");
      out.write("            --bs-table-border-color: #343a40; /* Borde oscuro */\n");
      out.write("            margin-top: 20px;\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        /* FUERZA EL COLOR BLANCO EN EL CUERPO DE LA TABLA para todos los datos que no tienen estado */\n");
      out.write("        .table-dark-custom tbody tr > * {\n");
      out.write("            color: #f8f9fa !important; /* Blanco */\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        /* Asegurar que la tabla ocupe el espacio sin desbordarse horizontalmente en móviles */\n");
      out.write("        .table-responsive {\n");
      out.write("            flex-grow: 1; \n");
      out.write("            overflow-y: auto; \n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Clases de estado condicional (el backend debe aplicarlas) */\n");
      out.write("        .text-success { /* Activo */\n");
      out.write("            color: #198754 !important;\n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("        .text-finalizado { /* Finalizado/Check-out */\n");
      out.write("            color: #dc3545 !important; /* Rojo de Bootstrap Danger */\n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("        .text-warning { /* Pendiente/Otro */\n");
      out.write("            color: #ffc107 !important;\n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    \n");
      out.write("    <!-- Contenedor principal: Tarjeta oscura (TEXT-WHITE) con sombra -->\n");
      out.write("    <div class=\"card consulta-dark-card text-white shadow-lg rounded-3\">\n");
      out.write("        \n");
      out.write("        <!-- Título/Cabecera de la Tarjeta (BG-BLACK) -->\n");
      out.write("        <div class=\"card-header bg-black text-center py-3 rounded-top-3\">\n");
      out.write("            <h2 class=\"mb-0\">Consultar Check-ins</h2>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <div class=\"card-body d-flex flex-column\">\n");
      out.write("            \n");
      out.write("            <!-- CONTENEDOR DE BOTONES DE ACCIÓN (Centrado horizontalmente) -->\n");
      out.write("            <div class=\"d-flex justify-content-center gap-3 mb-4 flex-wrap\">\n");
      out.write("                <button type=\"button\" class=\"btn btn-secundario btn-custom\">Mostrar Todos</button>\n");
      out.write("                <button type=\"button\" class=\"btn btn-secundario btn-custom\">Solo Activos</button>\n");
      out.write("                <button type=\"button\" class=\"btn btn-secundario btn-custom\">Solo Finalizados</button>\n");
      out.write("                <button type=\"button\" class=\"btn btn-principal btn-custom\">Actualizar</button>\n");
      out.write("                <button type=\"button\" class=\"btn btn-finalizar btn-custom\">Check-out</button>\n");
      out.write("                <button type=\"button\" onclick=\"window.history.back();\" class=\"btn btn-secundario btn-custom\">Regresar</button>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <!-- TABLA DE RESULTADOS (Responsive para móviles) -->\n");
      out.write("            <div class=\"table-responsive\">\n");
      out.write("                <table class=\"table table-dark-custom table-striped table-hover rounded-3\">\n");
      out.write("                    <thead>\n");
      out.write("                        <tr>\n");
      out.write("                            <!-- Columnas de datos del Check-in -->\n");
      out.write("                            <th scope=\"col\"># ID Check-in</th>\n");
      out.write("                            <th scope=\"col\">Huésped (Nombre)</th>\n");
      out.write("                            <th scope=\"col\">Apellido</th>\n");
      out.write("                            <th scope=\"col\">Cédula</th>\n");
      out.write("                            <th scope=\"col\">Teléfono</th>\n");
      out.write("                            <th scope=\"col\">F. Ingreso</th>\n");
      out.write("                            <th scope=\"col\">F. Salida</th>\n");
      out.write("                            <th scope=\"col\">Días</th>\n");
      out.write("                            <th scope=\"col\">Habitación</th>\n");
      out.write("                            <th scope=\"col\">Alergias</th>\n");
      out.write("                            <th scope=\"col\">Estado</th>\n");
      out.write("                            <th scope=\"col\">Observaciones</th>\n");
      out.write("                        </tr>\n");
      out.write("                    </thead>\n");
      out.write("                    <tbody>\n");
      out.write("                        <!-- \n");
      out.write("                            *** IMPORTANTE: Esta sección debe ser llenada dinámicamente por el código de servidor (ej. JSP) *** El código de servidor debe generar filas (<tr>) y aplicar las clases \n");
      out.write("                            condicionales (text-success, text-finalizado, text-warning) a la celda <td> del Estado.\n");
      out.write("                            Ejemplo de fila (que el servidor generaría):\n");
      out.write("                            <tr>\n");
      out.write("                                <th scope=\"row\">C001</th>\n");
      out.write("                                <td>Nombre</td>\n");
      out.write("                                <td>Apellido</td>\n");
      out.write("                                <td>Cédula</td>\n");
      out.write("                                <td>...</td>\n");
      out.write("                                <td class=\"text-success fw-bold\">Activo</td>\n");
      out.write("                                <td>...</td>\n");
      out.write("                            </tr>\n");
      out.write("                        -->\n");
      out.write("                    </tbody>\n");
      out.write("                </table>\n");
      out.write("                \n");
      out.write("                <!-- Mensaje de no resultados (oculto por defecto) -->\n");
      out.write("                <p id=\"no-checkins-msg\" class=\"text-center text-muted mt-5\" style=\"display:block;\">\n");
      out.write("                    No hay check-ins registrados o que coincidan con los criterios de búsqueda.\n");
      out.write("                </p>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <!-- Pie de página opcional para la tarjeta -->\n");
      out.write("        <div class=\"card-footer text-end text-muted py-2 bg-black rounded-bottom-3\">\n");
      out.write("            <small>Sistema de Gestión de Check-ins - Consulta</small>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("    \n");
      out.write("    <!-- JavaScript de BOOTSTRAP -->\n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js\" xintegrity=\"sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz\" crossorigin=\"anonymous\"></script>\n");
      out.write("    \n");
      out.write("    <script>\n");
      out.write("        // Lógica de ejemplo para mostrar/ocultar mensaje (en producción esto lo haría el servidor)\n");
      out.write("        window.onload = function() {\n");
      out.write("            const tableBody = document.querySelector('.table-dark-custom tbody');\n");
      out.write("            const noCheckinsMsg = document.getElementById('no-checkins-msg');\n");
      out.write("            \n");
      out.write("            // Si el código de servidor (JSP) insertara filas, el mensaje de \"No hay...\" debería ocultarse.\n");
      out.write("            if (tableBody && tableBody.rows.length > 0) {\n");
      out.write("                noCheckinsMsg.style.display = 'none';\n");
      out.write("            } else {\n");
      out.write("                noCheckinsMsg.style.display = 'block';\n");
      out.write("            }\n");
      out.write("        };\n");
      out.write("    </script>\n");
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
