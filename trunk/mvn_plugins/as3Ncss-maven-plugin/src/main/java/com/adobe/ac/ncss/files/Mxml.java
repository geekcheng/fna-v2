package com.adobe.ac.ncss.files;

import java.util.List;

import com.adobe.ac.ncss.files.AbstractFlexFile.InCodeFlag;
import com.adobe.ac.ncss.files.AbstractFlexFile.InCommentFlag;

public class Mxml
      extends AbstractFlexFile
{

   public Mxml(
         final List< String > lines )
   {
      super( lines );
   }

   @Override
   protected int computeFunctionsInFile()
   {
      int functions = 0;

      for ( String line : fileContent )
      {
         if ( line.contains( "function " ) )
         {
            functions++;
         }
      }
      return functions;
   }

   @Override
   protected int computeLinesOfCodeInFile()
   {
      InCodeFlag flag = new InCodeFlag();
      boolean inMxml = true;

      for ( String line : fileContent )
      {
         if ( !inMxml )
         {
            updateInAs3CodeFlag( line, flag );
         }
         else
         {
            updateInMxmlCodeFlag( line, flag );
         }
      }

      return flag.linesOfCode;
   }

   private void updateInMxmlCodeFlag(
         String line, InCodeFlag flag )
   {
      if ( line.contains( "<!--" ) )
      {
         flag.inComment = true;
      }
      if ( flag.inComment )
      {
         if ( line.contains( "-->" ) )
         {
            flag.inComment = false;
         }
      }
      else
      {
         flag.linesOfCode++;
      }
   }

   @Override
   protected int computeLinesOfCommentsInFile()
   {
      InCommentFlag flag = new InCommentFlag();
      boolean inMxml = true;

      for ( String line : fileContent )
      {
         if ( !inMxml )
         {
            updateInAs3CommentFlag( flag, line );
         }
         else
         {
            updateInMxmlCommentFlag( flag, line );
         }
         if ( line.contains( "<" ) && line.contains( "Script>" ) )
         {
            inMxml = false;
         }
         else
         {
            if ( line.contains( "</" ) && line.contains( "Script>" ) )
            {
               inMxml = true;
            }
         }
      }

      return flag.linesOfComment;
   }

   private void updateInMxmlCommentFlag(
         InCommentFlag flag, String line )
   {
      if ( line.contains( "<!--" ) )
      {
         flag.inComment = true;
      }
      if ( flag.inComment )
      {
         if ( line.contains( "-->" ) )
         {
            flag.inComment = false;
         }
         else
         {
            flag.linesOfComment++;
         }
      }
   }
}
