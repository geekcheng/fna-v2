package com.adobe.ac.ncss;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Collection;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;

import com.adobe.ac.ncss.filters.FlexFilter;
import com.adobe.ac.ncss.metrics.AverageClassMetrics;
import com.adobe.ac.ncss.metrics.AverageFunctionMetrics;
import com.adobe.ac.ncss.metrics.ClassMetrics;
import com.adobe.ac.ncss.metrics.FunctionMetrics;
import com.adobe.ac.ncss.metrics.PackageMetrics;
import com.adobe.ac.ncss.metrics.ProjectMetrics;
import com.adobe.ac.ncss.metrics.TotalPackageMetrics;
import com.adobe.ac.ncss.utils.FileUtils;

public abstract class AbstractNcss
{

   protected Collection< File > filePaths = null;
   protected Collection< File > nonEmptyDirectories = null;
   final private File reportFile;
   private File sourceDirectoryPath = null;
   

   public AbstractNcss(
         final File outputFile, final Collection< File > filePaths, final File sourceDirectoryPath )
   {
      super();
      this.filePaths = filePaths;
      if ( sourceDirectoryPath != null )
      {
         this.filePaths = FileUtils.listFiles( sourceDirectoryPath, new FlexFilter(), true );
         this.nonEmptyDirectories = FileUtils.listNonEmptyDirectories( sourceDirectoryPath, true );
         this.sourceDirectoryPath = sourceDirectoryPath;
      }
      reportFile = outputFile;
   }
   
   protected String getQualifiedName( final File file )
   {
      final String qualifiedName = file.getAbsolutePath().replace( sourceDirectoryPath.getAbsolutePath() , "" ).replace( "/", "." ).replace( "\\", "." ).replace( ".as", "" );
      
      if( qualifiedName.charAt( 0 ) == '.' )
      {
         return qualifiedName.substring( 1 );
      }
      
      return qualifiedName;
   }

   public void execute()
   {
      writeReport( loadMetrics() );
   }

   protected abstract ProjectMetrics loadMetrics();

   private void writeReport(
         final ProjectMetrics metrics )
   {
      writeReport( buildReport( metrics ) );
   }

   private String buildReport(
         final ProjectMetrics metrics )
   {
      final StringBuffer buf = new StringBuffer(70);

      buf.append( "<?xml version=\"1.0\"?>" );
      buf.append( "<javancss>" );
      buf.append( "<date>" + metrics.getDate() + "</date>" );
      buf.append( "<time>" + metrics.getTime() + "</time>" );

      buf.append( addPackages( metrics ) );
      buf.append( addObjects( metrics ) );
      buf.append( addFunctions( metrics ) );

      buf.append( "</javancss>" );

      return buf.toString();
   }

   private String addFunctions(
         final ProjectMetrics metrics )
   {
      final StringBuffer buffer = new StringBuffer(25);

      buffer.append( "<functions>" );

      for ( FunctionMetrics functionMetrics : metrics.getFunctionMetrics() )
      {
         buffer.append( functionMetrics.toXmlString() );
      }
      
      appendAverageFunction( buffer, metrics.getAverageFunctions(), metrics.getTotalPackages().getTotalStatements() );
      
      buffer.append( "</functions>" );

      return buffer.toString();
   }

   private String addObjects(
         final ProjectMetrics metrics )
   {
      final StringBuffer buffer = new StringBuffer(20);

      buffer.append( "<objects>" );

      for ( ClassMetrics classMetrics : metrics.getClassMetrics() )
      {
         buffer.append( classMetrics.toXmlString() );
      }
      
      appendAverageObject( buffer, metrics.getAverageObjects(), metrics.getTotalPackages().getTotalStatements() );
      
      buffer.append( "</objects>" );

      return buffer.toString();
   }
   
   private void appendAverageObject(
         final StringBuffer buffer, final AverageClassMetrics metrics, final int totalNcss )
   {
      final int averageClasses = 0;

      buffer.append( "<averages><classes>" + averageClasses  + "</classes>" );
      buffer.append( "<functions>" + metrics.getAverageFunctions() + "</functions>" );
      buffer.append( "<ncss>" + metrics.getAverageStatements()  + "</ncss>" );
      buffer.append( "<javadocs>" + metrics.getAverageAs3DocLines() + "</javadocs></averages>" );
      buffer.append( "<ncss>" + totalNcss  + "</ncss>" );
   }
   
   private void appendAverageFunction(
         final StringBuffer buffer, final AverageFunctionMetrics metrics, final int totalNcss )
   {
      buffer.append( "<function_averages><ncss>" + metrics.getAverageStatements() + "</ncss>" );
      buffer.append( "<javadocs>" + metrics.getAverageAs3DocLines() + "</javadocs>" );
      buffer.append( "</function_averages>" );
      buffer.append( "<ncss>" + totalNcss  + "</ncss>" );
   }

   private String addPackages(
         final ProjectMetrics metrics )
   {
      final StringBuffer buffer = new StringBuffer();

      buffer.append( "<packages>" );

      for ( PackageMetrics packageMetrics : metrics.getPackageMetrics() )
      {
         buffer.append( packageMetrics .toXmlString() );
      }
      appendTotalPackages( buffer, metrics.getTotalPackages() );

      return buffer.toString();
   }

   private void appendTotalPackages(
         final StringBuffer buffer, final TotalPackageMetrics metrics )
   {
      final int totalJavadocs = 0;
      final int totalSingleCommentLine = 0;
      final int totalMultiCommentLine = 0;

      buffer.append( "<total><classes>" + metrics.getTotalClasses() + "</classes>" );
      buffer.append( "<functions>" + metrics.getTotalFunctions() + "</functions>" );
      buffer.append( "<ncss>" + metrics.getTotalStatements() + "</ncss>" );
      buffer.append( "<javadocs>" + totalJavadocs  + "</javadocs>" );
      buffer.append( "<javadoc_lines>" + metrics.getTotalAs3DocLine()  + "</javadoc_lines>" );
      buffer.append( "<single_comment_lines>" + totalSingleCommentLine  + "</single_comment_lines>" );
      buffer.append( "<multi_comment_lines>" + totalMultiCommentLine  + "</multi_comment_lines></total>" );
      
      buffer.append( "</packages>" );
   }

   private void writeReport(
         final String report )
   {
      Document document;
      OutputFormat format;
      XMLWriter writer;

      try
      {
         document = DocumentHelper.parseText( report );
         format = OutputFormat.createPrettyPrint();
         writer = new XMLWriter( new FileOutputStream( reportFile ), format );
         writer.write( document );
         writer.close();
      }
      catch ( DocumentException e )
      {
         e.printStackTrace();
      }
      catch ( UnsupportedEncodingException e )
      {
         e.printStackTrace();
      }
      catch ( FileNotFoundException e )
      {
         e.printStackTrace();
      }
      catch ( IOException e )
      {
         e.printStackTrace();
      }
   }
}