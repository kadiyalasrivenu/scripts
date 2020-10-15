
import java.sql.*;
import oracle.jdbc.*;
class Test3
{


  public static ResultSet retrieveSelectItems(Connection conn) throws SQLException
  {
    String SQL;
    ResultSet rs;
    PreparedStatement pStmt;
    SQL  = "select a from x" ;
    pStmt = conn.prepareStatement(SQL);
    rs = pStmt.executeQuery();
    return rs;
  }


  public static void main(String args[]) throws SQLException
  {
    Connection conn = null;
    ResultSet rset = null;
    try
    {
      DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
      conn = DriverManager.getConnection
        ("jdbc:oracle:thin:@sophpadb01:1536:sgqdev", "apps", "apps");

	for (int i=0;i<10000;i++) {
		rset=retrieveSelectItems(conn);
    		while( rset.next() )
    		{
			String va = rset.getString(1);
	      		System.out.println( va );
    		}
		rset.close();
	}

    }
    finally
    {
      rset.close();
      conn.close();
    }
  }


} 

