
import java.sql.*;

public class JDBC {
   static final String JDBCDriver = "com.mysql.jdbc.Driver";
   static final String DBURL = "jdbc:mysql://localhost/cs157aproject";
    
   static final String USER = "root";
   static final String PW = "";
   private static Connection conn = null;
   private static Statement stmt = null;
   
   public static void main(String [] args) throws SQLException
   {
       try
       {
    	   // Register JDBC driver
           Class.forName("com.mysql.jdbc.Driver");
           
           // Open a connection
           System.out.println("Connecting to database...");
           conn = DriverManager.getConnection(DBURL, USER, PW);
           
           Statement stmt = null;
           try {
        	   System.out.println("\nSelecting all users...");
        	   // Create statement
        	   stmt = conn.createStatement();
        	   String sql = "SELECT * FROM user";
        	   
        	   // Execute Statement
        	   rs = stmt.executeQuery(sql);
        	   printUserResultSet(rs);
        	   
        	   System.out.println("\nInserting user...");
        	   String sql = "INSERT INTO user VALUES ('StevenLiu', 'Steven', 'Liu', '1@1.1', '123')";
        	   
        	   rs = stmt.executeUpdate(sql);
        	   printUserResultSet(rs);
        	   
        	   System.out.println("\nDeleting user...");
        	   String sql = "DELETE * FROM user WHERE name = 'Steven'";
        	   
        	   rs = stmt.executeUpdate(sql);
        	   printUserResultSet(rs);
        	   
        	   System.out.println("\nSelecting all users...");
        	   // Create statement
        	   sql = "SELECT * FROM users";
        	   
        	   // Execute Statement
        	   rs = stmt.executeQuery(sql);
        	   printUserResultSet(rs);
        	   
           }
           catch (SQLException e) {}
           finally { stmt.close();}
           
           
           
       }
       catch(SQLException sqle)
       {
           sqle.printStackTrace();
       }
       catch(Exception ex)
       {
           ex.printStackTrace();
       }
       finally
       {
           try
           {
               if(stmt!=null) stmt.close();
           }
           catch(SQLException sqlex){}
       }
   }
    private static void makeDatabase() throws SQLException
    {
      String database = "DROP DATABASE IF EXISTS stickynotes";
      Statement statement = conn.createStatement();
      statement.execute(database);
      
      System.out.println("Creating database");
      stmt = conn.createStatement();
      stmt.execute("CREATE DATABASE stickynotes");
      System.out.println("Created database");
      
    }
    
    private static void printUserResultSet (ResultSet rs) throws SQLException
    {
    	while (rs.next())
    	{
    		int id = rs.getInt("ID");
    		String firstname = rs.getString("firstname");
    		String lastname = rs.getString("lastname");
    		System.out.println("userID: " + id + ", first name: " + firstname + ", last name: " + lastname);
    	}
    }
    
   
}
