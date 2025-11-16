package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class Menu_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>Sistema de Gestión Hotelera - Inicio</title>\n");
      out.write("    <!-- Enlace a Bootstrap CSS -->\n");
      out.write("    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("    <style>\n");
      out.write("        /* Estilos generales para el modo oscuro */\n");
      out.write("        body {\n");
      out.write("            background-color: #212529; /* Gris oscuro de fondo */\n");
      out.write("            color: #f8f9fa; /* Color de texto blanco/claro */\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Estilos de Navbar y Dropdown para modo oscuro */\n");
      out.write("        .navbar {\n");
      out.write("            box-shadow: 0 2px 5px rgba(0,0,0,.5);\n");
      out.write("        }\n");
      out.write("        .dropdown-menu {\n");
      out.write("            background-color: #343a40; /* Fondo del menú desplegable más oscuro */\n");
      out.write("            border: 1px solid rgba(255, 255, 255, 0.1);\n");
      out.write("        }\n");
      out.write("        .dropdown-item {\n");
      out.write("            color: #f8f9fa; /* Texto claro en el menú */\n");
      out.write("        }\n");
      out.write("        .dropdown-item:hover {\n");
      out.write("            background-color: #0d6efd; /* Azul primario de Bootstrap en hover */\n");
      out.write("            color: #ffffff;\n");
      out.write("        }\n");
      out.write("        .dropdown-divider {\n");
      out.write("            border-top: 1px solid rgba(255, 255, 255, 0.15); /* Separador sutil */\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Estilo del Carrusel */\n");
      out.write("        .carrusel-container {\n");
      out.write("            padding: 20px;\n");
      out.write("            /* Calcula la altura total de la vista menos la altura de la navbar para centrar bien */\n");
      out.write("            min-height: calc(100vh - 56px); \n");
      out.write("            display: flex;\n");
      out.write("            align-items: center; /* Centrar verticalmente */\n");
      out.write("            justify-content: center; /* Centrar horizontalmente */\n");
      out.write("            background-color: #212529; \n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        .carrusel-bordeado {\n");
      out.write("            max-width: 1000px; /* Ancho máximo para el carrusel en escritorio */\n");
      out.write("            box-shadow: 0 0 20px rgba(0, 123, 255, 0.5); /* Sombra azul para destacar en dark mode */\n");
      out.write("            border: 3px solid #0d6efd; /* Borde de color primario */\n");
      out.write("            overflow: hidden;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .carousel-item img {\n");
      out.write("            height: 500px; \n");
      out.write("            object-fit: cover; \n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .carousel-caption {\n");
      out.write("            background: rgba(0, 0, 0, 0.6); \n");
      out.write("            border-radius: 5px;\n");
      out.write("            padding: 10px;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("    <!-- BARRA DE NAVEGACIÓN (NAVBAR) - COMPLETA Y DARK MODE -->\n");
      out.write("    <nav class=\"navbar navbar-expand-lg navbar-dark bg-dark\">\n");
      out.write("        <div class=\"container-fluid\">\n");
      out.write("            <!-- Título de la Aplicación -->\n");
      out.write("            <a class=\"navbar-brand text-white fw-bold\" href=\"Bienvenida.html\">GESTIÓN HOTEL</a>\n");
      out.write("            \n");
      out.write("            <!-- Botón de Menú Móvil (Toggler) -->\n");
      out.write("            <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navbarNavDropdown\" aria-controls=\"navbarNavDropdown\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\n");
      out.write("                <span class=\"navbar-toggler-icon\"></span>\n");
      out.write("            </button>\n");
      out.write("            \n");
      out.write("            <div class=\"collapse navbar-collapse\" id=\"navbarNavDropdown\">\n");
      out.write("                <ul class=\"navbar-nav me-auto mb-2 mb-lg-0\">\n");
      out.write("                    \n");
      out.write("                    <!-- Dropdown Archivo (Dashboard y Cerrar Sesión) -->\n");
      out.write("                    <li class=\"nav-item dropdown\">\n");
      out.write("                        <a class=\"nav-link dropdown-toggle active\" href=\"#\" id=\"navbarDropdownArchivo\" role=\"button\" data-bs-toggle=\"dropdown\" aria-expanded=\"false\" aria-current=\"page\">\n");
      out.write("                            Archivo\n");
      out.write("                        </a>\n");
      out.write("                        <ul class=\"dropdown-menu\" aria-labelledby=\"navbarDropdownArchivo\">\n");
      out.write("                            <li><a class=\"dropdown-item text-danger\" href=\"index.jsp\">Cerrar Sesión</a></li>\n");
      out.write("                            <li><hr class=\"dropdown-divider\"></li>\n");
      out.write("                            \n");
      out.write("                        </ul>\n");
      out.write("                    </li>\n");
      out.write("                    \n");
      out.write("                    <!-- Cliente -->\n");
      out.write("                    <li class=\"nav-item\">\n");
      out.write("                        <a class=\"nav-link text-white\" href=\"NuevoCliente.jsp\">Cliente</a>\n");
      out.write("                    </li>\n");
      out.write("\n");
      out.write("                    <!-- Dropdown Reservas -->\n");
      out.write("                    <li class=\"nav-item dropdown\">\n");
      out.write("                        <a class=\"nav-link dropdown-toggle text-white\" href=\"#\" id=\"navbarDropdownReservas\" role=\"button\" data-bs-toggle=\"dropdown\" aria-expanded=\"false\">\n");
      out.write("                            Reservas\n");
      out.write("                        </a>\n");
      out.write("                        <ul class=\"dropdown-menu\" aria-labelledby=\"navbarDropdownReservas\">\n");
      out.write("                            <li><a class=\"dropdown-item\" href=\"NuevaReserva.jsp\">Reservar</a></li>\n");
      out.write("                            <li><a class=\"dropdown-item\" href=\"ConsultarReserva.jsp\">Consultar Reservas</a></li>\n");
      out.write("                        </ul>\n");
      out.write("                    </li>\n");
      out.write("                    \n");
      out.write("                    <!-- Dropdown Check-in/out -->\n");
      out.write("                    <li class=\"nav-item dropdown\">\n");
      out.write("                        <a class=\"nav-link dropdown-toggle text-white\" href=\"#\" id=\"navbarDropdownCheckin\" role=\"button\" data-bs-toggle=\"dropdown\" aria-expanded=\"false\">\n");
      out.write("                            Check-in/out\n");
      out.write("                        </a>\n");
      out.write("                        <ul class=\"dropdown-menu\" aria-labelledby=\"navbarDropdownCheckin\">\n");
      out.write("                            <li><a class=\"dropdown-item\" href=\"NuevoCheckin.jsp\">Nuevo Check-in</a></li>\n");
      out.write("                            <li><a class=\"dropdown-item\" href=\"ConsultarCheckin.jsp\">Consultar Check-ins</a></li>\n");
      out.write("                        </ul>\n");
      out.write("                    </li>\n");
      out.write("\n");
      out.write("                    <!-- Habitación -->\n");
      out.write("                    <li class=\"nav-item\">\n");
      out.write("                        <a class=\"nav-link text-white\" href=\"NuevaHabitacion.jsp\">Habitación</a>\n");
      out.write("                    </li>\n");
      out.write("                    \n");
      out.write("                    <!-- Dropdown Productos (Registro, Ventas y Consultas) -->\n");
      out.write("                    <li class=\"nav-item dropdown\">\n");
      out.write("                        <a class=\"nav-link dropdown-toggle text-white\" href=\"#\" id=\"navbarDropdownProductos\" role=\"button\" data-bs-toggle=\"dropdown\" aria-expanded=\"false\">\n");
      out.write("                            Productos\n");
      out.write("                        </a>\n");
      out.write("                        <ul class=\"dropdown-menu\" aria-labelledby=\"navbarDropdownProductos\">\n");
      out.write("                            <!-- Nueva opción agregada -->\n");
      out.write("                            <li><a class=\"dropdown-item\" href=\"RegistrarProductos.jsp\">Registrar Producto</a></li>\n");
      out.write("                            <li><hr class=\"dropdown-divider\"></li>\n");
      out.write("                            <li><a class=\"dropdown-item\" href=\"NuevaVenta.jsp\">Ventas</a></li>\n");
      out.write("                            <li><a class=\"dropdown-item\" href=\"ConsultarVentas.jsp\">Consultar Ventas</a></li>\n");
      out.write("                        </ul>\n");
      out.write("                    </li>\n");
      out.write("                    <!-- Fin Dropdown Productos -->\n");
      out.write("\n");
      out.write("                    <li class=\"nav-item\">\n");
      out.write("                        <a class=\"nav-link text-danger\" href=\"#\">Reportes</a>\n");
      out.write("                    </li>\n");
      out.write("                </ul>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </nav>\n");
      out.write("    \n");
      out.write("    <!-- CONTENEDOR DEL CARRUSEL CENTRADO -->\n");
      out.write("    <div class=\"container carrusel-container\">\n");
      out.write("\n");
      out.write("        <div id=\"carouselExampleIndicators\" class=\"carousel slide w-100 rounded-3 carrusel-bordeado\" data-bs-ride=\"carousel\">\n");
      out.write("            <div class=\"carousel-indicators\">\n");
      out.write("                <button type=\"button\" data-bs-target=\"#carouselExampleIndicators\" data-bs-slide-to=\"0\" class=\"active\" aria-current=\"true\" aria-label=\"Slide 1\"></button>\n");
      out.write("                <button type=\"button\" data-bs-target=\"#carouselExampleIndicators\" data-bs-slide-to=\"1\" aria-label=\"Slide 2\"></button>\n");
      out.write("                <button type=\"button\" data-bs-target=\"#carouselExampleIndicators\" data-bs-slide-to=\"2\" aria-label=\"Slide 3\"></button>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"carousel-inner\">\n");
      out.write("                <div class=\"carousel-item active\">\n");
      out.write("                    <!-- Placeholder de imagen: Habitación de Lujo -->\n");
      out.write("                    <img src=\"https://placehold.co/1000x500/0d6efd/ffffff?text=Habitacion+VIP\" class=\"d-block w-100\" alt=\"Habitación 1\">\n");
      out.write("                    <div class=\"carousel-caption d-none d-md-block\">\n");
      out.write("                        <h5 class=\"fw-bold\">Habitaciones de Lujo</h5>\n");
      out.write("                        <p>Las mejores comodidades para su estancia.</p>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"carousel-item\">\n");
      out.write("                    <!-- Placeholder de imagen: Piscina -->\n");
      out.write("                    <img src=\"https://placehold.co/1000x500/198754/ffffff?text=Area+de+Piscina\" class=\"d-block w-100\" alt=\"Piscina\">\n");
      out.write("                    <div class=\"carousel-caption d-none d-md-block\">\n");
      out.write("                        <h5 class=\"fw-bold\">Área de Piscina</h5>\n");
      out.write("                        <p>Relájese bajo el sol.</p>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"carousel-item\">\n");
      out.write("                    <!-- Placeholder de imagen: Restaurante -->\n");
      out.write("                    <img src=\"https://placehold.co/1000x500/ffc107/343a40?text=Restaurante+Gourmet\" class=\"d-block w-100\" alt=\"Restaurante\">\n");
      out.write("                    <div class=\"carousel-caption d-none d-md-block\">\n");
      out.write("                        <h5 class=\"fw-bold\">Restaurante Gourmet</h5>\n");
      out.write("                        <p>Pruebe nuestra cocina de autor.</p>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("            <!-- Controles Prev/Next -->\n");
      out.write("            <button class=\"carousel-control-prev\" type=\"button\" data-bs-target=\"#carouselExampleIndicators\" data-bs-slide=\"prev\">\n");
      out.write("                <span class=\"carousel-control-prev-icon\" aria-hidden=\"true\"></span>\n");
      out.write("                <span class=\"visually-hidden\">Previous</span>\n");
      out.write("            </button>\n");
      out.write("            <button class=\"carousel-control-next\" type=\"button\" data-bs-target=\"#carouselExampleIndicators\" data-bs-slide=\"next\">\n");
      out.write("                <span class=\"carousel-control-next-icon\" aria-hidden=\"true\"></span>\n");
      out.write("                <span class=\"visually-hidden\">Next</span>\n");
      out.write("            </button>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <!-- Enlace a Bootstrap JS (necesario para el carrusel y los dropdowns) -->\n");
      out.write("    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js\"></script>\n");
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
