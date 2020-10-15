/*
* This sample to demonstrate Implicit Statement Caching. This can be
* enabled by calling setStatementCacheSize and setImplicitCachingEnabled(true)
* on the Connection Object.
*
* Please use jdk1.2 or later version
*
* Please look at the "1. stmt is ..." and "2. stmt is ..." of the
* running results. They should point to the same instance (address)
* 
*/ 

// You need to import the java.sql package to use JDBC
import java.sql.*;
import javax.sql.*;
import oracle.jdbc.*;
import oracle.jdbc.pool.OracleDataSource;

class StmtCache1
{
public static void main (String args [])
throws SQLException
{
// Create a OracleDataSource instance explicitly
OracleDataSource ods = new OracleDataSource();
ods.setMaxStatements(1);
ods.setImplicitCachingEnabled(true);

// Set the user name, password, driver type and network protocol
ods.setUser("scott");
ods.setPassword("tiger");
ods.setDriverType("oci8");
ods.setNetworkProtocol("ipc");

// Retrieve a connection
Connection conn = ods.getConnection();


Connection sysconn = DriverManager.getConnection("jdbc:oracle:oci8:@",
"system", "manager");
String sql = "select EMPNO, ENAME from EMP";

System.out.println("Beging of 1st execution");
getOpenCursors (sysconn);

// Create a Statement
PreparedStatement stmt = conn.prepareStatement (sql);
System.out.println("1. Stmt is " + stmt);


// Select the FIRST_NAME, LAST_NAME column from the EMPLOYEES table
ResultSet rset = stmt.executeQuery ();

// Iterate through the result and print the employee names
while (rset.next ())
System.out.println (rset.getString (1) + " " + rset.getString (2));

// Close the RseultSet
rset.close();

// Close the Statement
stmt.close();

System.out.println("End of 1st execution");
getOpenCursors (sysconn);

System.out.println("Reexecuting the same SQL");

stmt = conn.prepareStatement (sql);

System.out.println("2. Stmt is " + stmt);

// Select the FIRST_NAME, LAST_NAME column from the EMPLOYEES table
rset = stmt.executeQuery ();

// Iterate through the result and print the employee names
while (rset.next ())
System.out.println (rset.getString (1) + " " + rset.getString (2));

// Close the RseultSet
rset.close();

// Close the Statement
stmt.close();

System.out.println("End of 2nd execution");
getOpenCursors (sysconn);

// Close the connection
conn.close(); 

System.out.println("After close of connection");
getOpenCursors (sysconn);

sysconn.close();
}

private static void getOpenCursors (Connection conn)
throws SQLException
{
System.out.println("Open Cusrors are : ");
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery ("select SQL_TEXT from V$OPEN_CURSOR");
while (rs.next())
System.out.println("Cursor's sql text is " + rs.getString(1));
rs.close();
rs = null;
stmt.close();
stmt = null;
}
}


