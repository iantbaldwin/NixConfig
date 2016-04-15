import java.util.*;

/**
 * A program which formats the working directory
 * to a more compact form. 
 *
 * Format specification:
 * - The root directory is /
 * - The last directory in the working directory tree
 *   is represente with its entire name
 * - Any directory not the last in the tree is represented
 *   with that directory's first letter or a period and the
 *   first letter if it is a hidden directory.
 * - The user's home directory is replaced with ~
 *
 * @author Ian Baldwin
 * @version 1.0
 */
public class Shorten {

  /**
   * Program execution. 
   *
   * @param args Not used in this program.
   */
  public static void main( String[] args ) {

    /** Get the working directory and the user's home. */
    String workingDir = System.getenv( "PWD" );
    String home = System.getenv( "HOME" );


    /** Exchange the home value for ~ */
    workingDir = workingDir.replaceAll( home, "~" );

    /** Setup the Scanner and StringBuilder */
    Scanner pathScanner = new Scanner( workingDir );
    pathScanner.useDelimiter( "/" );
    StringBuilder outputBuilder = new StringBuilder();
    

    /** If there is nothing to scan, we must be at root( / ) */
    if ( !pathScanner.hasNext() )
      outputBuilder.append( "/" );

    /** Parse the path and format the output. */
    while( pathScanner.hasNext() ) {
      
      // read the next value
      String value = pathScanner.next();

      // If the value is ~, then only append ~
      if ( value.equals( "~" ) )
        outputBuilder.append( value );

      // If the value starts with a period and it isn't the final
      // directory, append a seperator, a period, and the first
      // letter.
      else if ( value.startsWith( "." ) && pathScanner.hasNext() )
        outputBuilder.append( "/." + value.charAt( 1 ) );


      // If there is nothing left to scan, value is the last directory
      // so appened the entire name.
      else if ( !pathScanner.hasNext() )
        outputBuilder.append( "/" + value );
      
      // Otherwise, just appened a seperator and the first letter of
      // the directory. 
      else
        outputBuilder.append( "/" + value.charAt( 0 ) );
    }

    /** Print the output and close the Scanner */
    System.out.print( outputBuilder.toString() );
    pathScanner.close();
  }
}
