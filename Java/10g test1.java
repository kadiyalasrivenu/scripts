import java.sql.*;
import oracle.jdbc.pool.*;

class test1
{

public static void main (String args [])
  throws SQLException, ClassNotFoundException
  {
	OracleDataSource ods = new OracleDataSource();
	ods.setUser("eposmig");
      	ods.setPassword("Tecpsos$7002#");
	ods.setURL("jdbc:oracle:thin:@172.17.7.23:1521/eposprd.ttsl.com");
	Connection conn = ods.getConnection();

	String sq = "select OBJECT_ID from user_objects ";
	Statement stmt = conn.createStatement ();
      	ResultSet rset = stmt.executeQuery (sq);
      	int rowsProcessed = 0;
      	while (rset.next ()) {
         	String objectid = rset.getString(1);
		System.out.println( objectid );
         	rowsProcessed++;
         	if(rowsProcessed % 10000 == 0) {
            		System.out.println("Rows Processed " + rowsProcessed);
         	}
 	}
  }
}