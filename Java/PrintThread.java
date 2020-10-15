/*  program to demonstrate concurrency*/

class PrintThread implements Runnable { 
   String str; 
   public PrintThread () { 
    ;
   } 

   public void run() { 
      for (;;) ;
   } 
} 

class ConcurrencyTest { 
   public static void main (String Args[]) { 
      new Thread(new PrintThread()).start(); 
      new Thread(new PrintThread()).start(); 
      new Thread(new PrintThread()).start(); 
      new Thread(new PrintThread()).start(); 
   } 
} 