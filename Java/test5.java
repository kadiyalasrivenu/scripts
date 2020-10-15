
import java.sql.*;
import oracle.jdbc.*;

class test5
{

public static void main (String args [])
  throws SQLException, ClassNotFoundException
  {
    Connection conn = null;
    ResultSet rset = null;

        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
      conn = DriverManager.getConnection
        ("jdbc:oracle:oci:@dwops", "kadiyala_dba", "");

        PreparedStatement pStmt;
        ResultSet rs;
        String SQL;
        SQL = 	" SELECT /*+ RULE  */ extract_job_profile_id, revision, valid_to_utc, " +
		" valid_from_utc, created_by_user_id, last_updated_by_user_id, extract_profile_type_id, " +
		" description, xml, time_clause_column_name, time_clause_column_tz, time_clause_offset_hours, " +
		" time_clause_hours, parallel_clause_table_name, parallel_clause_table_alias, " + 
		" parallel_clause_uses_index, file_template, autogen_table_name, autogen_table_owner, " +
		" autogen_column_options, parallelization_method FROM DWP_EXTRACT_JOB_PROFILES ejp " + 
		" WHERE ejp.valid_to_utc > sysdate AND ejp.revision = (SELECT MAX (ejp1.revision) " + 
		" FROM dwp_extract_job_profiles ejp1 WHERE ejp1.extract_job_profile_iD = ejp.extract_job_profile_ID) ";
        pStmt = conn.prepareStatement(SQL);
	rs = pStmt.executeQuery();
    	while( rs.next() )
	{
		String va = rs.getString(1);
		System.out.println( va );
	}
	rset.close();
  }

}

