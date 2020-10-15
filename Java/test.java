import java.sql.*;
import oracle.jdbc.pool.*;

class test
{

public static void main (String args [])
  throws SQLException, ClassNotFoundException
  {
	OracleDataSource ods = new OracleDataSource();
	ods.setUser("apps");
      	ods.setPassword("apps");
	ods.setURL("jdbc:oracle:oci:@sgqdev");
	Connection conn = ods.getConnection();

	CallableStatement cs1 = conn.prepareCall ( "{call p2 ()}" ) ;
	cs1.executeUpdate();
  }

}
