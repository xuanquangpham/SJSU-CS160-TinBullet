/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stickynotes;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
/**
 *
 * @author quangpham
 */
public class DBConnectionTest {
     
    private static final String QUERY = "select username, firstname, lastname, email, password from Users";
 
    public static void main(String[] args) {
                 
        //using try-with-resources to avoid closing resources (boiler plate code)
        try(Connection con = DBConnection.getConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(QUERY)) { 
             
            while(rs.next()){
                String username = rs.getString("username");
                String firstname = rs.getString("firstname");
                String lastname = rs.getString("lastname");
                String email = rs.getString("email");
                String password = rs.getString("password");
                System.out.println(username + "," +firstname+ ","+lastname+ "," +email+ "," +password);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
         
    }
 
}
