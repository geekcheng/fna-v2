package com.adobe.ac.ncss.utils;

import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.adobe.ac.ncss.filters.DirectoryFilter;
import com.adobe.ac.ncss.filters.FlexFilter;

public class FileUtils
{
   public static Collection< File > listFiles(
         final File directory, final FilenameFilter filter, final boolean recurse )
   {
      final Collection< File > files = new ArrayList< File >();
      final File[] entries = directory.listFiles();
      for ( File entry : entries )
      {
         if ( filter == null || filter.accept( directory, entry.getName() ) )
         {
            files.add( entry );
         }
         if ( recurse && entry.isDirectory() )
         {
            files.addAll( listFiles( entry, filter, recurse ) );
         }
      }
      return files;
   }

   public static Collection< File > listNonEmptyDirectories(
         final File directory, final boolean recurse )
   {
      final Collection< File > files = new ArrayList< File >();
      final File[] entries = directory.listFiles( new DirectoryFilter() );
      final FlexFilter flexFilter = new FlexFilter();

      for ( File entry : entries )
      {
         if ( entry.isDirectory() && !listFiles( entry, flexFilter, false ).isEmpty() )
         {
            files.add( entry );
         }
         if ( recurse && entry.isDirectory() )
         {
            files.addAll( listNonEmptyDirectories( entry, recurse ) );
         }
      }
      return files;
   }

   public static List< String > readFile(
         final File file )
   {
      final List< String > content = new ArrayList< String >();

      FileInputStream fis = null;
      BufferedInputStream bis = null;
      DataInputStream dis = null;

      try
      {
         fis = new FileInputStream( file );
         bis = new BufferedInputStream( fis );
         dis = new DataInputStream( bis );

         while ( dis.available() != 0 )
         {
            content.add( dis.readLine() );
         }

         // dispose all the resources after using them.
         fis.close();
         bis.close();
         dis.close();

      }
      catch ( FileNotFoundException e )
      {
         e.printStackTrace();
      }
      catch ( IOException e )
      {
         e.printStackTrace();
      }
      return content;
   }

   public static boolean isLineACorrectStatement(
         final String line )
   {
      return line.compareTo( "" ) != 0 && lrtrim( line ).compareTo( "{" ) != 0 && lrtrim( line ).compareTo( "}" ) != 0 && line.contains( ";" );
   }

   /* remove leading whitespace */
   private static String ltrim(
         final String source )
   {
      return source.replaceAll( "^\\s+", "" );
   }

   /* remove trailing whitespace */
   private static String rtrim(
         final String source )
   {
      return source.replaceAll( "\\s+$", "" );
   }

   /* replace multiple whitespaces between words with single blank */
   private static String itrim(
         final String source )
   {
      return source.replaceAll( "\\b\\s{2,}\\b", " " );
   }

   /* remove all superfluous whitespaces in source string */
   public static String trim(
         final String source )
   {
      return itrim( ltrim( rtrim( source ) ) );
   }

   private static String lrtrim(
         final String source )
   {
      return ltrim( rtrim( source ) );
   }
}
