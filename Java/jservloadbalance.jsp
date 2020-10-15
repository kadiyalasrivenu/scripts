Under directory <iAS Home>/Apache/Jserv/servlets compile the java program using the following command: 

$AF_JRE_TOP/bin/javac -classpath <iAS_Home>/Apache/Jsdk/lib/jsdk.jar txkTestJservLoadBal.java 



Execute the compiled test servlet by accessing the following URL: 

<web_entry_protocol>://<web_entry_point>.<web_entry_domain>:<web_entry_port>/servlets/txkTestJservLoadBal


This should show the "Response from <hostname>". If you click on the reload then you should see hostnames of the other servers which participate in the Apache JServ Layer Load Balancing as well. 



import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class txkTestJservLoadBal extends HttpServlet {
 public static final String TITLE = "Testing JServLoad Balancing";
 public void service (HttpServletRequest request, HttpServletResponse response)
   throws ServletException, IOException
   {
   response.setContentType("text/html");
 PrintWriter out = response.getWriter();
 String serverName = request.getServerName();
   out.println("Response from " + serverName );
   }
 }
