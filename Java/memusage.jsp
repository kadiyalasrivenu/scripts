<%@ page language="java" import="java.lang.*"%>
<%@ page language="java" import="java.io.*"%>
<HTML>
<BODY>
<%
    String[] cmd1 = { "/bin/bash", "-c", "hostname" };
    String[] cmd2 = { "/bin/bash", "-c", "echo $PPID" };


      Runtime rt = Runtime.getRuntime(); 
      try { 
         // Run the OS command and wait for its thread 
         Process pr1 = rt.exec( cmd1 ); 
         pr1.waitFor(); 


         // Buffer the process's input stream, get data by lines 
         BufferedReader ins1 = new BufferedReader( 
              new InputStreamReader( pr1.getInputStream() ) ); 
         String input; 
         while( (input = ins1.readLine()) != null ) 
            out.println("Server = "+input); 
            out.println("<BR>"); 
         ins1.close(); 
      } catch ( InterruptedException ignored ) {
      } catch ( IOException e ) {               
         e.printStackTrace(); 
      }
      try { 
         // Run the OS command and wait for its thread 
         Process pr2 = rt.exec( cmd2 ); 
         pr2.waitFor(); 


         // Buffer the process's input stream, get data by lines 
         BufferedReader ins2 = new BufferedReader( 
              new InputStreamReader( pr2.getInputStream() ) ); 
         String input; 
         while( (input = ins2.readLine()) != null ) 
            out.println("PID = "+input); 

         ins2.close(); 
      } catch ( InterruptedException ignored ) {
      } catch ( IOException e ) {               
         e.printStackTrace(); 
      } 
%>
<BR>
The total memory is now <%= Runtime.getRuntime().totalMemory() %>
<BR>
The free memory is now <%= Runtime.getRuntime().freeMemory() %>
<BR>
</BODY>
</HTML>