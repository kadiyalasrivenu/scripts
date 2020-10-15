
import java.sql.*;
import oracle.jdbc.*;
class Test4
{


  public static PreparedStatement retrieveSelectItems(Connection conn) throws SQLException
  {
    String SQL;
    ResultSet rs;
    PreparedStatement pStmt;
    SQL  = "select a from x" ;
    pStmt = conn.prepareStatement(SQL);
    return pStmt;
  }


  public static void main(String args[]) throws SQLException
  {
    Connection conn = null;
    PreparedStatement pStmt = null;
    ResultSet rset = null;
    try
    {
      DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
      conn = DriverManager.getConnection
        ("jdbc:oracle:thin:@sophpadb01:1536:sgqdev", "apps", "apps");
	CallableStatement cs1 = conn.prepareCall ( "alter session set sql_trace=true" ) ;
	cs1.executeUpdate();


	for (int i=0;i<1000;i++) {
		System.out.println("Loop "+i);
		pStmt=retrieveSelectItems(conn);
		rset=pStmt.executeQuery();
    		while( rset.next() )
    		{
			String va = rset.getString(1);
	      		System.out.println( va );
    		}
		pStmt.close();
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

