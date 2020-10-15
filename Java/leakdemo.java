import java.sql.*;
import oracle.jdbc.pool.*;

class leakdemo
{

public static void main (String args [])
  throws SQLException, ClassNotFoundException
  {
	OracleDataSource ods = new OracleDataSource();
	ods.setUser("apps");
      	ods.setPassword("apps");
	ods.setURL("jdbc:oracle:oci:@sgqdev");
	Connection conn = ods.getConnection();

	String sq = "select OBJECT_ID from user_objects ";
	Statement stmt = conn.createStatement ();
      	ResultSet rset = stmt.executeQuery (sq);
      	int rowsProcessed = 0;
      	while (rset.next ()) {
         	String objectid = rset.getString(1);
         	showDetails(objectid);
         	rowsProcessed++;
         	if(rowsProcessed % 10000 == 0) {
            		System.out.println("Rows Processed " + rowsProcessed);
         	}
 	}
  }
 
 private static void showDetails(String objectid) throws SQLException {
	OracleDataSource ods = new OracleDataSource();
	ods.setUser("apps");
      	ods.setPassword("apps");
	ods.setURL("jdbc:oracle:oci:@sgqdev");
	Connection conn = ods.getConnection();

      		String sq = "select object_name from user_objects where object_id = ?"; 
      		PreparedStatement ps = conn.prepareStatement(sq);
      		ps.setString(1,objectid);
      		ResultSet rset = ps.executeQuery ();
      		while (rset.next()) {
         		String objectname = rset.getString(1);
         		System.out.println(" Object is " + objectname);
      		}
  	}


}