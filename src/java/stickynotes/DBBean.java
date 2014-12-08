package stickynotes; 

import java.sql.*;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.Properties;


public class DBBean implements java.io.Serializable {

	Connection con = null;
	Statement stat = null;
	ResultSet rs = null;

	public DBBean() {
		connect(); //create the connection with db server
	}

	/*
	 * Load the driver and connect to database
	 */
	public void connect() {
		Properties prop = new Properties();
    	InputStream input = null;
    	String file = "db.properties";
	
		try {
			input = this.getClass().getClassLoader().getResourceAsStream(file);
			if (input == null){
				System.out.println("Sorry, unable to find " + file);
				return;
    		}
    		prop.load(input);
			// load the Driver Class
            Class.forName(prop.getProperty("DB_DRIVER_CLASS"));
 
            // create the connection now
            con = DriverManager.getConnection(prop.getProperty("DB_URL"),
                    prop.getProperty("DB_USERNAME"),
                    prop.getProperty("DB_PASSWORD"));
			input.close();
			stat = con.createStatement();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * Get the result at a specific row
	 * @param row the postion in list of result sets
	 */	
	public void gotoRow(int row) {
		try {
			for(int i=0; i<row; i++) rs.next();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * Execute a SQL statement and get the results
	 * @param str the sql string
	 */
	public void queryString(String str) {
		try {
			rs = stat.executeQuery(str);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * Execute a SQL statement to insert, update, delete. No results return needed
	 * @param str the sql string
	 */
	public void update(String str) {
		try {
			stat.executeUpdate(str);
		} catch(Exception e) {
			e.printStackTrace(); 
		}
	}

	/*
	 * Check if there is a result
	 * @return true if there is a record
	 */
	public boolean isNext() {
		try {
			if(rs != null && rs.next()) return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	/*
	 * Close the connection
	 */
	public void close() {
		try {
			if(rs != null) rs.close();
			if(stat != null) stat.close();
			if(con != null) con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}

	/*
	 * Get result set type String by column name and return a string
	 * @param name column name of result set
	 * @return value of the column
	 */
	public String getString(String name) {
		if((rs == null) || ("".equals(name))) return "";

		String s = "";
		try {
			s = rs.getString(name);
			if(s == null) s = "";
		}
		catch(Exception e) { e.printStackTrace(); }
		return s;
	}

	/*
	 * Get result set type String by column position and return a string
	 * @param i column position in result set
	 * @return value of the column	 
	 */
	public String getString(int i) {
		if((rs == null) || (i <= 0)) return "";

		String s = "";
		try {
			s = rs.getString(i);
			if(s == null) s = "";
		}
		catch(Exception e) { e.printStackTrace(); }
		return s;
	}

	/*
	 * Get result set type Int by column name and return a string
	 * @param name column name of result set
	 * @return value of the column	 
	 */
	public String getInt(String name) {
		if((rs == null) || ("".equals(name))) return "";

		String s = "";
		try {
			s = String.valueOf(rs.getInt(name));
			if(s == null) s = "";
		}
		catch(Exception e) { e.printStackTrace(); }
		return s;
	}

	/*
	 * Get result set type Int by column position and return a string
	 * @param i column position in result set
	 * @return value of the column	 
	 */
	public String getInt(int i) {
		if((rs == null) || (i <= 0)) return "";

		String s = "";
		try {
			s = String.valueOf(rs.getInt(i));
			if(s == null) s = "";
		}
		catch(Exception e) { e.printStackTrace(); }
		return s;
	}

	/*
	 * Get result set type Date by column name and return a string
	 * @param name column name of result set
	 * @return date as string	 
	 */
	public String getDate(String name) {
		if((rs == null) || ("".equals(name))) return "";

		String s = "";
		try {
			s = rs.getDate(name).toString();
			if(s == null) s = "";
		}
		catch(Exception e) { e.printStackTrace(); }
		return s;
	}

	/*
	 * Get result set type Date by column position and return a string
	 * @param i column position in result set
	 * @return value of the column	 
	 */
	public String getDate(int i) {
		if((rs == null) || (i <= 0)) return "";

		String s = "";
		try {
			s = rs.getDate(i).toString();
			if(s == null) s = "";
		}
		catch(Exception e) { e.printStackTrace(); }
		return s;
	}

	/*
	 * Get result set type Time by column name and return a string
	 * @param name column name of result set
	 * @return time as string	 
	 */
	public String getTime(String name) {
		if((rs == null) || ("".equals(name))) return "";

		String s = "";
		try {
			s = rs.getTime(name).toString();
			if(s == null) s = "";
		}
		catch(Exception e) { e.printStackTrace(); }
		return s;
	}

	/*
	 * Get result set type Time by column position and return a string
	 * @param i column position in result set
	 * @return value of the column	 
	 */
	public String getTime(int i) {
		if((rs == null) || (i <= 0)) return "";

		String s = "";
		try {
			s = rs.getTime(i).toString();
			if(s == null) s = "";
		}
		catch(Exception e) { e.printStackTrace(); }
		return s;
	}	
	/*
	 * Check if table has a specific data at a column
	 * @param table the table name
	 * @param col the column name
	 * @param name condition to compare
	 * @return true if return any records, otherwise false
	 */
	public boolean isExist(String table, String col, String name) {
		boolean flag = false;
		try {
			ResultSet rs1 = stat.executeQuery("SELECT " + col + " FROM " + table + " WHERE " + col + "='" + name + "'");
			if(rs1 != null && rs1.next()) flag = true;
			rs1.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	/*
	 * Check if a query returns any result or not
	 * @param query an sql query
	 * @return true if return any records, otherwise false	 
	 */
	public boolean isExist(String query) {
		boolean flag = false;
		try {
			ResultSet rs1 = stat.executeQuery(query);
			if(rs1 != null && rs1.next()) flag = true;
			rs1.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	/*
	 * Return the column names of the result set
	 * @return a list of column name
	 */
	public String[] getFieldsName() throws SQLException {
		ResultSetMetaData meta = rs.getMetaData();
		int count = meta.getColumnCount();
		String []field = new String[count];
	
		for(int i=0; i<count; i++)
			field[i] = meta.getColumnLabel(i+1);
		return field;
	}
};