package com.adobe.ac.ncss.files;

import java.util.List;

public class As3
      extends AbstractFlexFile
{
   public As3(
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

      for ( String line : fileContent )
      {
         updateInAs3CodeFlag( line, flag );
      }

      return flag.linesOfCode;
   }

   @Override
   protected int computeLinesOfCommentsInFile()
   {
      InCommentFlag flag = new InCommentFlag();

      for ( String line : fileContent )
      {
         updateInAs3CommentFlag( flag, line );
      }

      return flag.linesOfComment;
   }
}
