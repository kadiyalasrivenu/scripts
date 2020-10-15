import java.io.*;
import java.net.*;

class StressTest extends Thread {
	String url1, file;
	public StressTest(String url , String file) {
		this.url1 = url;
		this.file = file;
	}

	public void run() {
	
		try {

			OutputStream to_file;
			to_file = new FileOutputStream(file);
			URL url = new URL(url1);
			String protocol = url.getProtocol();
			if (!protocol.equals("http"))
			throw new IllegalArgumentException("URL must use 'http:' protocol");
			String host = url.getHost();
			int port = url.getPort();
			if (port == -1) port = 80;  
			String filename = url.getFile();
			Socket socket = new Socket(host, port);
			InputStream from_server = socket.getInputStream();
			PrintWriter to_server = 
			new PrintWriter(new OutputStreamWriter(socket.getOutputStream()));
      
			to_server.println("GET " + filename +" HTTP/1.0\n");
			to_server.flush();  
      
			byte[] buffer = new byte[4096];
			int bytes_read;
			while((bytes_read = from_server.read(buffer)) != -1)
			to_file.write(buffer, 0, bytes_read);
      
			socket.close();
			to_file.close();
		}
		catch (Exception e) {    
			System.err.println(e);
      
		}
	}



	public static void main(String[] args) {

	if ((args.length != 1) && (args.length != 3)) {
	
     System.out.println("Wrong number of arguments !!  Syntax is java StressTest url filename threads");
     System.exit(0);
      
	}
		for (int i = 0; i < Integer.parseInt(args[2]) ; i++) {

			StressTest t = new StressTest(args[0] ,args[1]+i);
			System.out.println("Firing Thread " +i);
			t.start();
		}
	}
}
