<%@ page contentType="text/html;charset=US-ASCII"
    import="java.util.ArrayList" %>
<%!
  public static ArrayList sList = new ArrayList();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>
GC Test
</title>
</head>
<body>
<% 
  if( request.getParameter("UseMemory") != null) {
    String sizeStr = request.getParameter("size");
    int size = 50;
    if( sizeStr != null && sizeStr.length() > 0 ) {
      size = Integer.parseInt(sizeStr);
    }
    sList.add(new Object[size*1024*1024/4]); //50MB
    out.println("Used " + size + " MB.");
  }
  else if( request.getParameter("FreeMemory") != null) {
    if( sList.size() > 0 ) {
      int i = sList.size() - 1;
      long s = ((Object[]) sList.get(i)).length;
      s = (s*4/1024)/1024;
      sList.remove(sList.size()-1);
      out.println("Freed " + s + " MB.");
    }
    else 
      out.println("Have no more objects to release");
  }
  else if( request.getParameter("InvokeGC") != null) {
    Runtime.getRuntime().gc();
    out.println("Invoked GC");
  }
  long totalMemory = Runtime.getRuntime().totalMemory();
  long freeMemory = Runtime.getRuntime().freeMemory();
%>
<form name="myForm" id="myForm">
<table>
<tr><td>Total Memory: <%= totalMemory %> (<%= totalMemory/1024/1024 %>) MB</td></tr>
<tr><td>Used Memory: <%= (totalMemory-freeMemory) %> (<%= (totalMemory-freeMemory)/1024/1024 %>) MB</td></tr>
<tr><td>Free Memory: <%= freeMemory %> (<%= freeMemory/1024/1024 %>) MB</td></tr>
<tr><td>
Size: <input type="text" name="size" id="size" value="100">MB&nbsp;&nbsp;&nbsp;&nbsp;<input name="UseMemory" type="Submit" value="Use memory">
</td></tr>
<tr><td><input name="FreeMemory" type="Submit" value="Free memory"></td></tr>
<tr><td><input name="InvokeGC" type="Submit" value="Invoke GC"></td></tr>
</form>
</body>
</html>

