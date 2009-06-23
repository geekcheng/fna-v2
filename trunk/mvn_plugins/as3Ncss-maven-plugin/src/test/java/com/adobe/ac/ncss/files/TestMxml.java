package com.adobe.ac.ncss.files;

import java.io.File;
import java.net.URISyntaxException;

import junit.framework.TestCase;

import org.junit.Test;

import com.adobe.ac.ncss.utils.FileUtils;

public class TestMxml extends TestCase
{
   @Test
   public void testGetFunctionsCount() throws URISyntaxException
   {  
      Mxml iterationsList = new Mxml( FileUtils.readFile( new File( this.getClass().getResource( "/com/adobe/ac/ncss/mxml/IterationsList.mxml" ).toURI() ) ) );;
      Mxml iterationView = new Mxml( FileUtils.readFile( new File( this.getClass().getResource( "/com/adobe/ac/ncss/mxml/IterationView.mxml" ).toURI() ) ) );;

      assertEquals( 2, iterationsList.getFunctionsCount() );
      assertEquals( 2, iterationView.getFunctionsCount() );
   }

   @Test
   public void testGetLinesOfCode() throws URISyntaxException
   {
      Mxml iterationsList = new Mxml( FileUtils.readFile( new File( this.getClass().getResource( "/com/adobe/ac/ncss/mxml/IterationsList.mxml" ).toURI() ) ) );;
      Mxml iterationView = new Mxml( FileUtils.readFile( new File( this.getClass().getResource( "/com/adobe/ac/ncss/mxml/IterationView.mxml" ).toURI() ) ) );;

      assertEquals( 40, iterationsList.getLinesOfCode() );
      assertEquals( 87, iterationView.getLinesOfCode() );
   }   

   @Test
   public void testGetLinesOfComments() throws URISyntaxException
   {
      Mxml iterationsList = new Mxml( FileUtils.readFile( new File( this.getClass().getResource( "/com/adobe/ac/ncss/mxml/IterationsList.mxml" ).toURI() ) ) );;
      Mxml iterationView = new Mxml( FileUtils.readFile( new File( this.getClass().getResource( "/com/adobe/ac/ncss/mxml/IterationView.mxml" ).toURI() ) ) );;

      assertEquals( 2, iterationsList.getLinesOfComments() );
      assertEquals( 0, iterationView.getLinesOfComments() );
   }   
}
