package com.adobe.ac.ncss;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.adobe.ac.ncss.files.AbstractFlexFile;
import com.adobe.ac.ncss.files.As3;
import com.adobe.ac.ncss.files.Mxml;
import com.adobe.ac.ncss.filters.FlexFilter;
import com.adobe.ac.ncss.metrics.AverageClassMetrics;
import com.adobe.ac.ncss.metrics.AverageFunctionMetrics;
import com.adobe.ac.ncss.metrics.ClassMetrics;
import com.adobe.ac.ncss.metrics.FunctionMetrics;
import com.adobe.ac.ncss.metrics.PackageMetrics;
import com.adobe.ac.ncss.metrics.ProjectMetrics;
import com.adobe.ac.ncss.metrics.TotalPackageMetrics;
import com.adobe.ac.ncss.utils.FileUtils;

public class As3Ncss
      extends AbstractNcss
{
   private final List< PackageMetrics > packageMetrics = new ArrayList< PackageMetrics >();
   private final List< ClassMetrics > classMetrics = new ArrayList< ClassMetrics >();
   private final List< FunctionMetrics > functionMetrics = new ArrayList< FunctionMetrics >();

   public As3Ncss(
         final File outputDirectory, final Collection< File > filePaths )
   {
      super( outputDirectory, filePaths, null );
   }

   public As3Ncss(
         final File outputDirectory, final File sourceDirectoryPath )
   {
      super( outputDirectory, null, sourceDirectoryPath );
   }

   @Override
   protected ProjectMetrics loadMetrics()
   {
      final ProjectMetrics metrics = new ProjectMetrics();

      for ( final File directory : nonEmptyDirectories )
      {
         if ( directory.isDirectory() && !FileUtils.listFiles( directory, new FlexFilter(), true ).isEmpty() )
         {
            final String packageFullName = getQualifiedName( directory );
            final Collection< File > classesInPackage = FileUtils.listFiles( directory, new FlexFilter(), false );
            int functionsInPackage = 0;
            int ncssInPackage = 0;
            int as3DocInPackage = 0;

            for ( final File fileInPackage : classesInPackage )
            {
               AbstractFlexFile file;
               final List< String > lines = FileUtils.readFile( fileInPackage );
               
               if( fileInPackage.getName().endsWith( ".as" ) )
               {
                  file = new As3( lines );
               }
               else
               {
                  file = new Mxml( lines );
               }
                  
               final int functionsInClass = file.getFunctionsCount();
               final int ncssInClass = file.getLinesOfCode();
               final int as3DocInClass = file.getLinesOfComments();

               addFunctionMetrics( lines );

               functionsInPackage += functionsInClass;
               ncssInPackage += ncssInClass;
               as3DocInPackage += as3DocInClass;

               classMetrics.add( new ClassMetrics( ncssInClass, as3DocInClass, functionsInClass, fileInPackage.getName().replace( ".as", "" ), packageFullName ) );
            }
            packageMetrics.add( new PackageMetrics( ncssInPackage, as3DocInPackage, functionsInPackage, classesInPackage.size(), packageFullName ) );
         }
      }
      metrics.setPackageMetrics( packageMetrics );
      metrics.setClassMetrics( classMetrics );
      metrics.setFunctionMetrics( functionMetrics );
      metrics.setTotalPackages( getTotalPackages() );
      metrics.setAverageFunctions( getAverageFunctions() );
      metrics.setAverageObjects( getAverageObjects() );

      return metrics;
   }

   private void addFunctionMetrics(
         final List< String > lines )
   {
      boolean inFunction = false;
      String functionName = "";
      int parenthLevel = 0;
      int lineOfCode = 0;

      for ( String line : lines )
      {
         if ( line.contains( "function " ) )
         {
            inFunction = true;
            functionName = line.split( "function " )[ 1 ].split( "\\(" )[ 0 ];
            parenthLevel = 0;
            lineOfCode = 0;
         }
         if ( inFunction )
         {
            if ( line.contains( "{" ) )
            {
               parenthLevel++;
            }
            if ( line.contains( "}" ) )
            {
               parenthLevel--;
            }
            if ( parenthLevel == 0 && lineOfCode > 0 )
            {
               inFunction = false;
               functionMetrics.add( new FunctionMetrics( lineOfCode, 0, functionName, "" ) );
            }
            else
            {
               if (FileUtils.isLineACorrectStatement( line ) )
               {
                  lineOfCode++;
               }
            }
         }
      }

   }

   private AverageClassMetrics getAverageObjects()
   {
      int nonCommentStatement = 0;
      int functions = 0;
      int asDocs = 0;
      
      for ( ClassMetrics metrics : classMetrics )
      {
         nonCommentStatement += metrics.getNonCommentStatements();
         functions += metrics.getFunctions();
         asDocs += metrics.getAs3DocLine();
      }
      return new AverageClassMetrics( nonCommentStatement, asDocs, functions, classMetrics.size() );
   }

   private TotalPackageMetrics getTotalPackages()
   {
      int nonCommentStatement = 0;
      int functions = 0;
      int asDocs = 0;
      int classes = 0;
      
      for ( PackageMetrics metrics : packageMetrics )
      {
         nonCommentStatement += metrics.getNonCommentStatements();
         functions += metrics.getFunctions();
         asDocs += metrics.getAs3DocLine();
         classes += metrics.getClasses();
      }
      return new TotalPackageMetrics( nonCommentStatement, asDocs, functions, classes );
   }

   private AverageFunctionMetrics getAverageFunctions()
   {
      int nonCommentStatement = 0;
      int asDocs = 0;
      
      for ( FunctionMetrics metrics : functionMetrics )
      {
         nonCommentStatement += metrics.getNonCommentStatements();
         asDocs += metrics.getAs3DocLine();
      }

      return new AverageFunctionMetrics( nonCommentStatement, asDocs, functionMetrics.size() );
   }
}
