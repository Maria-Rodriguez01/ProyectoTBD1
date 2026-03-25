package proyectotbd1;

import java.sql.*;
import java.util.Scanner;

public class SistemaMenu {

    Connection conn;
    Scanner sc = new Scanner(System.in);
    int usuarioLogueado;

    public SistemaMenu(Connection conn) {
        this.conn = conn;
    }

    public void login() {
        try {
            System.out.println("+======================================+");
            System.out.println("|      SISTEMA DE PRESUPUESTO          |");
            System.out.println("|          PERSONAL - LOGIN            |");
            System.out.println("+======================================+");

            System.out.print("  Usuario : ");
            String correo = sc.nextLine();

            System.out.print("  Password: ");
            String pass = sc.nextLine();

            PreparedStatement ps = conn.prepareStatement(
                "SELECT id_usuario FROM usuario WHERE correo=? AND password=?");
            ps.setString(1, correo);
            ps.setString(2, pass);
            ResultSet rs2 = ps.executeQuery();

            if (rs2.next()) {
                usuarioLogueado = rs2.getInt("id_usuario");

                System.out.println("\n  >> Login exitoso. Bienvenido!");
                System.out.println("  --------------------------------------");

                if (correo.equals("admin") && pass.equals("admin")) {
                    menuAdmin();
                } else {
                    menuUsuario();
                }
            } else {
                System.out.println("\n  !! Correo o password incorrecto.");
                System.out.println("  --------------------------------------");
            }

        } catch (Exception e) {
            System.out.println("  Error: " + e.getMessage());
        }
    }

    public void menuAdmin() {
        int op;
        do {
            System.out.println("\n+======================================+");
            System.out.println("|         MENU ADMINISTRADOR           |");
            System.out.println("+======================================+");
            System.out.println("|  1 ->  Crear usuario                 |");
            System.out.println("|  2 ->  Listar usuarios               |");
            System.out.println("|  3 ->  Crear categoria               |");
            System.out.println("|  4 ->  Crear subcategoria            |");
            System.out.println("|  5 ->  Ver categorias                |");
            System.out.println("|  6 ->  Eliminar usuario              |");
            System.out.println("+--------------------------------------+");
            System.out.println("|  0 ->  Cerrar sesion                 |");
            System.out.println("+======================================+");
            System.out.print("  Seleccione una opcion: ");

            op = sc.nextInt();
            sc.nextLine();

            System.out.println("  --------------------------------------");

            switch (op) {
                case 1: crearUsuario(); break;
                case 2: listarUsuarios(); break;
                case 3: crearCategoria(); break;
                case 4: crearSubcategoria(); break;
                case 5: listarCategorias(); break;
                case 6: eliminarUsuario(); break;
                case 0:
                    System.out.println("  Cerrando sesion... Hasta luego!");
                    System.out.println("  --------------------------------------");
                    break;
                default:
                    System.out.println("  !! Opcion invalida. Intente de nuevo.");
                    break;
            }
        } while (op != 0);
    }

    public void menuUsuario() {

        int op;

        String nombreUsuario = "";
        try {
            CallableStatement cs = conn.prepareCall("{call sp_consultar_usuario(?)}");
            cs.setInt(1, usuarioLogueado);
            ResultSet rs = cs.executeQuery();

            if (rs.next()) {
                nombreUsuario = rs.getString("nombre") + " " + rs.getString("apellido");
            }
        } catch (Exception e) {
            nombreUsuario = "Usuario";
        }

        do {

            System.out.println("\n+======================================+");
            System.out.printf("|  USUARIO  |  %-22s|%n", nombreUsuario);
            System.out.println("+======================================+");
            System.out.println("| 1 -> Perfil usuario                  |");
            System.out.println("| 2 -> Presupuestos                    |");
            System.out.println("| 3 -> Transacciones                   |");
            System.out.println("| 4 -> Obligaciones fijas              |");
            System.out.println("+--------------------------------------+");
            System.out.println("| 0 -> Cerrar sesion                   |");
            System.out.println("+======================================+");
            System.out.print("Seleccione una opcion: ");

            op = sc.nextInt();
            sc.nextLine();

            switch (op) {
                case 1: menuPerfil(); break;
                case 2: menuPresupuestos(); break;
                case 3: menuTransacciones(); break;
                case 4: menuObligaciones(); break;
                case 0:
                    System.out.println("  Cerrando sesion... Hasta luego!");
                    break;
                default:
                    System.out.println("  !! Opcion invalida.");
                    break;
            }

        } while (op != 0);
    }

    public void menuPerfil() {

        int op;

        do {

            System.out.println("\n+======================================+");
            System.out.println("|              PERFIL                  |");
            System.out.println("+======================================+");
            System.out.println("| 1 -> Ver perfil                      |");
            System.out.println("| 2 -> Editar perfil                   |");
            System.out.println("+--------------------------------------+");
            System.out.println("| 0 -> Volver                          |");
            System.out.println("+======================================+");

            op = sc.nextInt();
            sc.nextLine();

            switch (op) {
                case 1: miPerfil(); break;
                case 2: editarPerfil(); break;
                case 0: break;
                default: System.out.println("  !! Opcion invalida."); break;
            }

        } while (op != 0);
    }

    public void menuPresupuestos() {

        int op;

        do {

            System.out.println("\n+======================================+");
            System.out.println("|            PRESUPUESTOS              |");
            System.out.println("+======================================+");
            System.out.println("| 1 -> Crear presupuesto               |");
            System.out.println("| 2 -> Listar presupuestos             |");
            System.out.println("| 3 -> Cerrar presupuesto              |");
            System.out.println("+--------------------------------------+");
            System.out.println("| 0 -> Volver                          |");
            System.out.println("+======================================+");

            op = sc.nextInt();
            sc.nextLine();

            switch (op) {
                case 1: crearPresupuesto(); break;
                case 2: listarPresupuestos(); break;
                case 3: cerrarPresupuesto(); break;
                case 0: break;
                default: System.out.println("  !! Opcion invalida."); break;
            }

        } while (op != 0);
    }

    public void menuTransacciones() {

        int op;

        do {

            System.out.println("\n+======================================+");
            System.out.println("|           TRANSACCIONES              |");
            System.out.println("+======================================+");
            System.out.println("| 1 -> Registrar transaccion           |");
            System.out.println("| 2 -> Volver                          |");
            System.out.println("+--------------------------------------+");

            op = sc.nextInt();
            sc.nextLine();

            switch (op) {
                case 1: registrarTransaccion(); break;
                case 2: break;
                default: System.out.println("  !! Opcion invalida."); break;
            }

        } while (op != 2);
    }

    public void menuObligaciones() {

        int op;

        do {

            System.out.println("\n+======================================+");
            System.out.println("|        OBLIGACIONES FIJAS            |");
            System.out.println("+======================================+");
            System.out.println("| 1 -> Crear obligacion                |");
            System.out.println("| 2 -> Listar obligaciones             |");
            System.out.println("| 3 -> Actualizar obligacion           |");
            System.out.println("| 4 -> Eliminar obligacion             |");
            System.out.println("| 5 -> Dias hasta vencimiento          |");
            System.out.println("+--------------------------------------+");
            System.out.println("| 0 -> Volver                          |");
            System.out.println("+======================================+");

            op = sc.nextInt();
            sc.nextLine();

            switch (op) {
                case 1: crearObligacionFija(); break;
                case 2: listarObligaciones(); break;
                case 3: actualizarObligacion(); break;
                case 4: eliminarObligacion(); break;
                case 5: diasHastaVencimiento(); break;
                case 0: break;
                default: System.out.println("  !! Opcion invalida."); break;
            }

        } while (op != 0);
    }

    public void miPerfil() {
        try {
            CallableStatement cs = conn.prepareCall("{call sp_consultar_usuario(?)}");
            cs.setInt(1, usuarioLogueado);
            ResultSet rs = cs.executeQuery();

            if (rs.next()) {
                System.out.println("\n+======================================+");
                System.out.println("|              MI PERFIL               |");
                System.out.println("+======================================+");
                System.out.printf("|  Nombre   : %-24s|%n", rs.getString("nombre"));
                System.out.printf("|  Apellido : %-24s|%n", rs.getString("apellido"));
                System.out.printf("|  Correo   : %-24s|%n", rs.getString("correo"));
                System.out.printf("|  Salario  : L. %-21.2f|%n", rs.getDouble("salario_mensual"));
                System.out.printf("|  Registro : %-24s|%n", rs.getString("fecha_registro"));
                System.out.println("+--------------------------------------+");
                System.out.println("|  1 ->  Editar perfil                 |");
                System.out.println("|  2 ->  Volver                        |");
                System.out.println("+======================================+");
                System.out.print("  Seleccione una opcion: ");

                int op = sc.nextInt();
                sc.nextLine();
                if (op == 1) editarPerfil();
            }

        } catch (Exception e) {
            System.out.println("  Error: " + e.getMessage());
        }
    }

    public void editarPerfil() {
        try {
            CallableStatement csConsulta = conn.prepareCall("{call sp_consultar_usuario(?)}");
            csConsulta.setInt(1, usuarioLogueado);
            ResultSet rs = csConsulta.executeQuery();
            rs.next();
            String nombreActual   = rs.getString("nombre");
            String apellidoActual = rs.getString("apellido");
            double salarioActual  = rs.getDouble("salario_mensual");

            System.out.println("\n+======================================+");
            System.out.println("|           EDITAR PERFIL              |");
            System.out.println("|   Deja en blanco para no cambiar     |");
            System.out.println("+======================================+");

            System.out.print("  Nuevo nombre   [" + nombreActual   + "]: "); String nombre     = sc.nextLine();
            System.out.print("  Nuevo apellido [" + apellidoActual + "]: "); String apellido   = sc.nextLine();
            System.out.print("  Nuevo salario  [" + salarioActual  + "]: "); String salarioStr = sc.nextLine();

            String nuevoNombre   = nombre.isEmpty()     ? nombreActual   : nombre;
            String nuevoApellido = apellido.isEmpty()   ? apellidoActual : apellido;
            double nuevoSalario  = salarioStr.isEmpty() ? salarioActual  : Double.parseDouble(salarioStr);

            CallableStatement cs = conn.prepareCall("{call sp_actualizar_usuario(?,?,?,?,?)}");
            cs.setInt(1, usuarioLogueado);
            cs.setString(2, nuevoNombre);
            cs.setString(3, nuevoApellido);
            cs.setDouble(4, nuevoSalario);
            cs.setString(5, "usuario");
            cs.execute();

            System.out.println("  >> Perfil actualizado exitosamente.");

        } catch (Exception e) {
            System.out.println("  Error: " + e.getMessage());
        }
    }

    public void crearUsuario() {
        try {
            System.out.println("\n+======================================+");
            System.out.println("|           CREAR USUARIO              |");
            System.out.println("+======================================+");
            System.out.print("  Nombre   : "); String nombre   = sc.nextLine();
            System.out.print("  Apellido : "); String apellido = sc.nextLine();
            System.out.print("  Correo   : "); String correo   = sc.nextLine();
            System.out.print("  Password : "); String password = sc.nextLine();
            System.out.print("  Salario  : "); double salario  = Double.parseDouble(sc.nextLine().trim());

            CallableStatement cs = conn.prepareCall("{call sp_insertar_usuario(?,?,?,?,?,?)}");
            cs.setString(1, nombre);
            cs.setString(2, apellido);
            cs.setString(3, correo);
            cs.setString(4, password);
            cs.setDouble(5, salario);
            cs.setString(6, "admin");
            cs.execute();

            System.out.println("  >> Usuario creado exitosamente.");

        } catch (Exception e) {
            System.out.println("  Error: " + e.getMessage());
        }
    }

    public void listarUsuarios() {
        try {
            CallableStatement cs = conn.prepareCall("{call sp_listar_usuarios()}");
            ResultSet rs = cs.executeQuery();

            System.out.println("\n+==================================================+");
            System.out.println("|               LISTA DE USUARIOS                  |");
            System.out.println("+==================================================+");
            System.out.printf("|  %-4s  |  %-15s  |  %-20s  |%n", "ID", "Nombre", "Correo");
            System.out.println("+--------------------------------------------------+");

            while (rs.next()) {
                System.out.printf("|  %-4d  |  %-15s  |  %-20s  |%n",
                    rs.getInt("id_usuario"),
                    rs.getString("nombre"),
                    rs.getString("correo"));
            }
            System.out.println("+==================================================+");

        } catch (Exception e) {
            System.out.println("  Error: " + e.getMessage());
        }
    }

    public void eliminarUsuario() {

        try {

            listarUsuarios();

            System.out.println("\n+======================================+");
            System.out.println("|           ELIMINAR USUARIO           |");
            System.out.println("+======================================+");

            System.out.print("ID Usuario a eliminar: ");
            int id = Integer.parseInt(sc.nextLine().trim());

            CallableStatement cs = conn.prepareCall("{call sp_eliminar_usuario(?)}");
            cs.setInt(1, id);
            cs.execute();

            System.out.println("Usuario eliminado correctamente");

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public void crearCategoria() {
        try {
            System.out.println("\n+======================================+");
            System.out.println("|          CREAR CATEGORIA             |");
            System.out.println("+======================================+");
            System.out.print("  Nombre         : "); String nombre = sc.nextLine();
            System.out.print("  Descripcion    : "); String desc   = sc.nextLine();
            System.out.println("  Tipo (ingreso / gasto / ahorro)");
            System.out.print("  Tipo           : "); String tipo   = sc.nextLine();
            System.out.print("  Id del usuario           : "); int idU = Integer.parseInt(sc.nextLine().trim());

            CallableStatement cs = conn.prepareCall("{call sp_insertar_categoria(?,?,?,?,?)}");
            cs.setString(1, nombre);
            cs.setString(2, desc);
            cs.setString(3, tipo);
            cs.setInt(4, idU);
            cs.setString(5, "admin");
            cs.execute();

            System.out.println("  >> Categoria creada exitosamente.");

        } catch (Exception e) {
            System.out.println("  Error: " + e.getMessage());
        }
    }

    public void crearSubcategoria() {
        try {
            listarCategorias();

            System.out.println("\n+======================================+");
            System.out.println("|         CREAR SUBCATEGORIA           |");
            System.out.println("+======================================+");
            System.out.print("  ID Categoria : "); int idCat = Integer.parseInt(sc.nextLine().trim());
            System.out.print("  Nombre       : "); String nombre = sc.nextLine();
            System.out.print("  Descripcion  : "); String desc   = sc.nextLine();

            CallableStatement cs = conn.prepareCall("{call sp_insertar_subcategoria(?,?,?,?,?)}");
            cs.setInt(1, idCat);
            cs.setString(2, nombre);
            cs.setString(3, desc);
            cs.setInt(4, 0);
            cs.setString(5, "admin");
            cs.execute();

            System.out.println("  >> Subcategoria creada exitosamente.");

        } catch (Exception e) {
            System.out.println("  Error: " + e.getMessage());
        }
    }

    public void listarCategorias() {
        try {
            CallableStatement cs = conn.prepareCall("{call sp_listar_categorias(?,?)}");
            cs.setInt(1, usuarioLogueado);
            cs.setNull(2, Types.VARCHAR);

            ResultSet rs = cs.executeQuery();

            System.out.println("\n+==========================================+");
            System.out.println("|           LISTA DE CATEGORIAS            |");
            System.out.println("+==========================================+");
            System.out.printf("|  %-4s  |  %-18s  |  %-8s  |%n", "ID", "Nombre", "Tipo");
            System.out.println("+------------------------------------------+");

            while (rs.next()) {
                System.out.printf("|  %-4d  |  %-18s  |  %-8s  |%n",
                    rs.getInt("id_categoria"),
                    rs.getString("nombre"),
                    rs.getString("tipo"));
            }
            System.out.println("+==========================================+");

        } catch (Exception e) {
            System.out.println("  Error: " + e.getMessage());
        }
    }

    public void listarPresupuestos() {
        try {
            CallableStatement cs = conn.prepareCall("{call sp_listar_presupuestos_usuario(?,?)}");
            cs.setInt(1, usuarioLogueado);
            cs.setNull(2, Types.BIT);

            ResultSet rs = cs.executeQuery();

            System.out.println("\n+============================================================+");
            System.out.println("|                   MIS PRESUPUESTOS                        |");
            System.out.println("+============================================================+");
            System.out.printf("|  %-4s  |  %-20s  |  %-10s  |  %-10s  |%n",
                "ID", "Nombre", "Inicio", "Fin");
            System.out.println("+------------------------------------------------------------+");

            while (rs.next()) {
                // FIX: Se usan los campos reales: year_inicio, mes_inicio, year_fin, mes_fin
                String inicio = rs.getInt("mes_inicio") + "/" + rs.getInt("year_inicio");
                String fin    = rs.getInt("mes_fin")    + "/" + rs.getInt("year_fin");
                System.out.printf("|  %-4d  |  %-20s  |  %-10s  |  %-10s  |%n",
                    rs.getInt("id_presupuesto"),
                    rs.getString("nombre"),
                    inicio,
                    fin);
            }
            System.out.println("+============================================================+");

        } catch (Exception e) {
            System.out.println("  Error: " + e.getMessage());
        }
    }

    public void crearPresupuesto() {
        try {
            System.out.println("\n+======================================+");
            System.out.println("|          CREAR PRESUPUESTO           |");
            System.out.println("+======================================+");
            System.out.print("  Nombre        : "); String nombre = sc.nextLine();
            System.out.print("  Anno inicio   : "); int yearInicio = Integer.parseInt(sc.nextLine().trim());
            System.out.print("  Mes inicio    : "); int mesInicio  = Integer.parseInt(sc.nextLine().trim());
            System.out.print("  Anno fin      : "); int yearFin    = Integer.parseInt(sc.nextLine().trim());
            System.out.print("  Mes fin       : "); int mesFin     = Integer.parseInt(sc.nextLine().trim());

            CallableStatement cs = conn.prepareCall("{call sp_insertar_presupuesto(?,?,?,?,?,?,?)}");
            cs.setInt(1, usuarioLogueado);
            cs.setString(2, nombre);
            cs.setInt(3, yearInicio);
            cs.setInt(4, mesInicio);
            cs.setInt(5, yearFin);
            cs.setInt(6, mesFin);
            cs.setString(7, "usuario");
            cs.execute();

            System.out.println("  >> Presupuesto creado exitosamente.");

        } catch (NumberFormatException e) {
            System.out.println("  Error: El anno y mes deben ser numeros enteros.");
        } catch (Exception e) {
            System.out.println("  Error: " + e.getMessage());
        }
    }

    public void cerrarPresupuesto() {

        try {

            listarPresupuestos();

            System.out.print("ID Presupuesto a cerrar: ");
            int idPres = Integer.parseInt(sc.nextLine().trim());

            CallableStatement cs = conn.prepareCall("{call sp_cerrar_presupuesto(?,?)}");
            cs.setInt(1, idPres);
            cs.setString(2, "usuario");
            cs.execute();

            System.out.println("Presupuesto cerrado correctamente");

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

public void registrarTransaccion() {

    try {

        listarPresupuestos();

        System.out.println("\n+======================================+");
        System.out.println("|        REGISTRAR TRANSACCION         |");
        System.out.println("+======================================+");

        System.out.print("  ID Presupuesto      : ");
        int idPres = Integer.parseInt(sc.nextLine());

        System.out.print("  Anno                : ");
        int anio = Integer.parseInt(sc.nextLine());

        System.out.print("  Mes (1-12)          : ");
        int mes = Integer.parseInt(sc.nextLine());

        System.out.println("\nTipo de transaccion:");
        System.out.println("1 - Subcategoria (gasto normal)");
        System.out.println("2 - Obligacion fija");

        System.out.print("Seleccione opcion: ");
        int opcion = Integer.parseInt(sc.nextLine());

        Integer idSubcategoria = null;
        Integer idObligacion = null;

        if(opcion == 1){

            listarSubcategorias();

            System.out.print("ID Subcategoria     : ");
            idSubcategoria = Integer.parseInt(sc.nextLine());

        } else {

            listarObligaciones();

            System.out.print("ID Obligacion Fija  : ");
            idObligacion = Integer.parseInt(sc.nextLine());

        }

        System.out.println("Tipo (ingreso / gasto / ahorro)");

        System.out.print("Tipo                : ");
        String tipo = sc.nextLine();

        System.out.print("Descripcion         : ");
        String descripcion = sc.nextLine();

        System.out.print("Monto               : ");
        double monto = Double.parseDouble(sc.nextLine());

        System.out.print("Fecha (YYYY-MM-DD)  : ");
        String fecha = sc.nextLine();

        System.out.print("Metodo de pago      : ");
        String metodo = sc.nextLine();

        System.out.print("Num. Factura        : ");
        String factura = sc.nextLine();

        System.out.print("Observaciones       : ");
        String obs = sc.nextLine();

        CallableStatement cs = conn.prepareCall(
        "{call sp_insertar_transaccion(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

        cs.setInt(1, idPres);
        cs.setInt(2, anio);
        cs.setInt(3, mes);

        if(idSubcategoria != null)
            cs.setInt(4, idSubcategoria);
        else
            cs.setNull(4, java.sql.Types.INTEGER);

        if(idObligacion != null)
            cs.setInt(5, idObligacion);
        else
            cs.setNull(5, java.sql.Types.INTEGER);

        cs.setString(6, tipo);
        cs.setString(7, descripcion);
        cs.setDouble(8, monto);
        cs.setDate(9, java.sql.Date.valueOf(fecha));
        cs.setString(10, metodo);
        cs.setString(11, factura);
        cs.setString(12, obs);
        cs.setString(13, "usuario");
        cs.setInt(14, usuarioLogueado);

        cs.execute();

        System.out.println("\n>> Transaccion registrada correctamente.");

    } catch (Exception e) {

        System.out.println("Error: " + e.getMessage());

    }

}

    public void listarSubcategorias() {
        try {
            CallableStatement csCat = conn.prepareCall("{call sp_listar_categorias(?,?)}");
            csCat.setInt(1, usuarioLogueado);
            csCat.setNull(2, Types.VARCHAR);
            ResultSet rsCat = csCat.executeQuery();

            System.out.println("\n+==========================================+");
            System.out.println("|            SUBCATEGORIAS                 |");
            System.out.println("+==========================================+");

            while (rsCat.next()) {
                int idCat  = rsCat.getInt("id_categoria");
                String cat = rsCat.getString("nombre");

                System.out.printf("  [ %s ]%n", cat);

                CallableStatement csSub = conn.prepareCall(
                    "{call sp_listar_subcategorias_por_categoria(?)}");
                csSub.setInt(1, idCat);
                ResultSet rsSub = csSub.executeQuery();

                while (rsSub.next()) {
                    System.out.printf("|  %-4d  |  %-30s  |%n",
                        rsSub.getInt("id_subcategoria"),
                        rsSub.getString("nombre"));
                }
            }
            System.out.println("+==========================================+");

        } catch (Exception e) {
            System.out.println("  Error: " + e.getMessage());
        }
    }

    public void diasHastaVencimiento() {

        try {

            System.out.print("ID Obligacion: "); int id = Integer.parseInt(sc.nextLine().trim());

            PreparedStatement ps = conn.prepareStatement(
                "SELECT fn_dias_hasta_vencimiento(?)");
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int dias = rs.getInt(1);
                System.out.println("Dias hasta vencimiento: " + dias);
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public void crearObligacionFija() {

        try {

            listarSubcategorias();

            System.out.println("\n+======================================+");
            System.out.println("|        CREAR OBLIGACION FIJA         |");
            System.out.println("+======================================+");

            System.out.print("ID Subcategoria          : "); int idSub = Integer.parseInt(sc.nextLine().trim());
            System.out.print("Nombre                   : "); String nombre = sc.nextLine();
            System.out.print("Descripcion              : "); String descripcion = sc.nextLine();
            System.out.print("Monto mensual            : "); double monto = Double.parseDouble(sc.nextLine().trim());
            System.out.print("Dia vencimiento (1-31)   : "); int dia = Integer.parseInt(sc.nextLine().trim());
            System.out.print("Fecha inicio (YYYY-MM-DD): "); String fechaInicio = sc.nextLine();

            CallableStatement cs = conn.prepareCall(
                "{call sp_insertar_obligacion(?,?,?,?,?,?,?,?,?)}");
            cs.setInt(1, idSub);
            cs.setString(2, nombre);
            cs.setString(3, descripcion);
            cs.setDouble(4, monto);
            cs.setInt(5, dia);
            cs.setDate(6, Date.valueOf(fechaInicio));
            cs.setNull(7, Types.DATE);   // fecha_fin opcional
            cs.setString(8, "usuario");
            cs.setInt(9, usuarioLogueado);
            cs.execute();

            System.out.println("Obligacion creada correctamente");

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public void listarObligaciones() {

        try {

            CallableStatement cs = conn.prepareCall(
                "{call sp_listar_obligaciones_usuario(?,?)}");
            cs.setInt(1, usuarioLogueado);
            cs.setShort(2, (short) 1);   
            ResultSet rs = cs.executeQuery();

            System.out.println("\n+======================================+");
            System.out.println("|        LISTA DE OBLIGACIONES         |");
            System.out.println("+======================================+");

            while (rs.next()) {
                System.out.println(
                    rs.getInt("id_obligacion") + " | " +
                    rs.getString("nombre") + " | L. " +
                    rs.getDouble("monto_mensual"));
            }
            System.out.println("+======================================+");

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public void actualizarObligacion() {

        try {

            listarObligaciones();

            System.out.println("\n+======================================+");
            System.out.println("|        ACTUALIZAR OBLIGACION         |");
            System.out.println("+======================================+");

            System.out.print("ID Obligacion: "); int id = Integer.parseInt(sc.nextLine().trim());

            System.out.print("Nuevo nombre: ");
            String nombre = sc.nextLine();

            System.out.print("Nueva descripcion: ");
            String descripcion = sc.nextLine();

            System.out.print("Nuevo monto                                      : "); double monto = Double.parseDouble(sc.nextLine().trim());
            System.out.print("Nuevo dia vencimiento (1-31)                     : "); int dia = Integer.parseInt(sc.nextLine().trim());
            System.out.print("Nueva fecha fin (YYYY-MM-DD, vacio si no aplica) : "); String fechaFinStr = sc.nextLine();

            // FIX: Se agregan los 8 parametros correctos del SP
            CallableStatement cs = conn.prepareCall(
                "{call sp_actualizar_obligacion(?,?,?,?,?,?,?,?)}");
            cs.setInt(1, id);
            cs.setString(2, nombre);
            cs.setString(3, descripcion);
            cs.setDouble(4, monto);
            cs.setInt(5, dia);
            if (fechaFinStr.isEmpty()) {
                cs.setNull(6, Types.DATE);
            } else {
                cs.setDate(6, Date.valueOf(fechaFinStr));
            }
            cs.setShort(7, (short) 1);   // activo = 1 (vigente)
            cs.setString(8, "usuario");
            cs.execute();

            System.out.println("Obligacion actualizada correctamente");

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    // ===== ELIMINAR OBLIGACION =====
    // Usa: sp_eliminar_obligacion(p_id_obligacion)
    public void eliminarObligacion() {

        try {

            listarObligaciones();

            System.out.println("\n+======================================+");
            System.out.println("|         ELIMINAR OBLIGACION          |");
            System.out.println("+======================================+");

            System.out.print("ID Obligacion a eliminar: "); int id = Integer.parseInt(sc.nextLine().trim());

            CallableStatement cs = conn.prepareCall("{call sp_eliminar_obligacion(?)}");
            cs.setInt(1, id);
            cs.execute();

            System.out.println("Obligacion eliminada correctamente");

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}