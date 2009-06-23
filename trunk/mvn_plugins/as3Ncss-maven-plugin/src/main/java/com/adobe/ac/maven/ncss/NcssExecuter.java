package com.adobe.ac.maven.ncss;

/*
 * Copyright 2004-2005 The Apache Software Foundation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import java.io.File;
import java.util.Collection;

import org.apache.maven.reporting.MavenReportException;

import com.adobe.ac.ncss.AbstractNcss;
import com.adobe.ac.ncss.As3Ncss;

/**
 * The NcssExecuter is able to call javaNCSS to produce a code analysis.<br>
 * The results are produced into a raw xml file.
 * 
 * @author <a href="jeanlaurent@gmail.com">Jean-Laurent de Morlhon</a>
 * 
 * @version $Id: NcssExecuter.java 3286 2007-02-08 20:18:51Z jeanlaurent $
 */
public class NcssExecuter
{
   // the full path to the directory holding the sources to point JavaNCSS to.
   // Or the location of a file holding the path towards all files. (javancss style *sigh* :)
   private File sourceLocation = null;

   // JavaNCSS will write an xml output into this file.
   private File outputDirectory = null;

   private Collection< File > fileList = null;

   /**
    * Construct a NcssExecuter with no arguments.<br>
    * Used for testing.
    */
   /* package */NcssExecuter()
   {
   }

   /**
    * Construct a NcssExecuter.
    * 
    * @param sourceDirectory
    *            the directory where the source to analyse are.
    * @param outputDirectory
    *            the output directory where the result will be written.
    */
   public NcssExecuter(
         final File sourceDirectory, final File outputDirectory )
   {
      this.sourceLocation = sourceDirectory;
      this.outputDirectory = outputDirectory;
   }

   public NcssExecuter(
         final Collection< File > fileList, final File outputDirectory )
   {
      this.fileList = fileList;
      this.outputDirectory = outputDirectory;
   }

   /**
    * Call the javaNCSS code analysis tool to produce the result to a temporary file name.<br>
    * 
    * @throws MavenReportException
    *             if somethings goes bad during the execution
    */
   public void execute() throws MavenReportException
   {
      AbstractNcss ncss;
      
      if ( ( sourceLocation != null ) && ( sourceLocation.isDirectory() ) )
      {
         ncss = new As3Ncss( outputDirectory, sourceLocation );
      }
      else
      {
         ncss = new As3Ncss( outputDirectory, fileList );         
      }
      
      ncss.execute();
   }
}
