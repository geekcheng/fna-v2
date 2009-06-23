package com.adobe.ac.ncss.files;

import java.util.List;

import com.adobe.ac.ncss.utils.FileUtils;

public abstract class AbstractFlexFile
{
   protected abstract class AbstractFlag
   {
      public boolean inComment = false;
   }

   protected class InCodeFlag
         extends AbstractFlag
   {
      public int linesOfCode = 0;
   }

   protected class InCommentFlag
         extends AbstractFlag
   {
      public int linesOfComment = 0;
   }

   private int functions;

   private int linesOfCode;

   private int linesOfComment;
   protected final List< String > fileContent;

   public AbstractFlexFile(
         final List< String > lines )
   {
      fileContent = lines;
      linesOfCode = computeLinesOfCodeInFile();
      linesOfComment = computeLinesOfCommentsInFile();
      functions = computeFunctionsInFile();
   }

   public int getFunctionsCount()
   {
      return functions;
   }

   public int getLinesOfCode()
   {
      return linesOfCode;
   }

   public int getLinesOfComments()
   {
      return linesOfComment;
   }

   protected abstract int computeFunctionsInFile();

   protected abstract int computeLinesOfCodeInFile();

   protected abstract int computeLinesOfCommentsInFile();

   protected void updateInAs3CodeFlag(
         String line, InCodeFlag flag )
   {
      if ( flag.inComment || line.contains( "//" ) )
      {
         if ( line.contains( "*/" ) )
         {
            flag.inComment = false;
         }
      }
      else
      {
         if ( line.contains( "/*" ) )
         {
            flag.inComment = true;
         }
         else if ( FileUtils.isLineACorrectStatement( line ) )
         {
            flag.linesOfCode++;
         }
      }
   }

   protected void updateInAs3CommentFlag(
         InCommentFlag flag, String line )
   {
      if ( flag.inComment || line.contains( "//" ) )
      {
         if ( line.contains( "*/" ) )
         {
            flag.inComment = false;
         }
         else
         {
            flag.linesOfComment++;
         }
      }
      else
      {
         if ( line.contains( "/*" ) )
         {
            flag.inComment = true;
         }
      }
   }
}
