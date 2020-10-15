import java.sql.*;
import java.math.*;
import java.io.*;
import oracle.jdbc.*;

class x
{

public static void main (String args [])
  throws SQLException, ClassNotFoundException
  {

      DriverManager.registerDriver
          (new oracle.jdbc.driver.OracleDriver());

      Connection conn=
        DriverManager.getConnection
        ("jdbc:oracle:oci8:@sgpatch",
          "apps", "sg29patch");

	CallableStatement cs1 = conn.prepareCall ( "{call px (?,?)}" ) ;
	

      for( int j = 0; j < 10; j++ )
      {
	cs1.setIntr(1,j);
	cs1.setIntr(2,j);
	cs1.executeUpdate();
      }
  }

}
