package proyectotbd1;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Maria Gabriela
 */

import java.sql.Connection;

public class ProyectoTBD1 {

    public static void main(String[] args) {

        try {

            Connection conn = DBConnection.conectar();

            SistemaMenu menu = new SistemaMenu(conn);

            menu.login();

        } catch (Exception e) {

            System.out.println(e.getMessage());

        }

    }

}