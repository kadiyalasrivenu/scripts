import java.sql.*;
import oracle.jdbc.pool.*;

class test1
{

public static void main (String args [])
  throws SQLException, ClassNotFoundException
  {
	OracleDataSource ods = new OracleDataSource();
	ods.setUser("apps");
      	ods.setPassword("apps");
	ods.setURL("jdbc:oracle:oci:@sgqdev");
	Connection conn = ods.getConnection();

	PreparedStatement pStmt;
     	ResultSet rs;
     	String SQL;
	CallableStatement cs1 = conn.prepareCall ( "alter session set sql_trace=true" ) ;
	cs1.executeUpdate();
     	SQL = "select x.a,y.b from x,y";
    	pStmt = conn.prepareStatement(SQL,ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_UPDATABLE);
	pStmt.execute ();
  }

}

