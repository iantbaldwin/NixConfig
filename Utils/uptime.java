import java.util.Scanner;

public class uptime {
  public static void main( String[] args ) {
    String uptime = "4:29  up 6 days,  9:35, 3 users, load averages: 1.36 1.26 1.26";
    Scanner timeScanner = new Scanner( uptime );
    timeScanner.next();
    timeScanner.next();
    String word = timeScanner.next();
    while ( timeScanner.hasNext() ) {
      // If the word is a number, followed by users, then break
      //
      // If the word is a n:n then replace the : with h and add an m to the end
      // otherwise, print it
      String print;
      if (  word.length() == 1 ) {
        String temp = timeScanner.next();
        if ( temp.equals( "users," ) || temp.equals( "user," ) )
          break;
        else
          print = word + " " + temp;
      } else if ( word.contains( ":" ) ) {
        word = word.replace( ",", "" );
        word = word.replace( ":", "h" );
        word = word.concat( "m" );
        print = word;
      } else
        print = word;

      System.out.print( print + " " );
      word = timeScanner.next();
    }
    System.out.println( "\n" );
  }
}
