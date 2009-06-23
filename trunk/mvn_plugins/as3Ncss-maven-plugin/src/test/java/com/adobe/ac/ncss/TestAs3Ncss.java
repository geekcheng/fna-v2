package com.adobe.ac.ncss;

import java.io.File;
import java.net.URISyntaxException;

import junit.framework.TestCase;

import org.junit.Test;

import com.adobe.ac.ncss.metrics.ProjectMetrics;

public class TestAs3Ncss
      extends TestCase
{
   @Test
   public void testLoadMetrics() throws URISyntaxException
   {
      final As3Ncss ncss = new As3Ncss( null, new File( this.getClass().getResource( "/com/adobe/ac/ncss" ).toURI() ) );
      final ProjectMetrics metrics = ncss.loadMetrics();

      assertNotNull( metrics );

      assertEquals( 12, metrics.getClassMetrics().size() );

      assertEquals( 3, metrics.getPackageMetrics().size() );

      assertEquals( 67, metrics.getFunctionMetrics().size() );
   }
   
   @Test
   public void testExtecute() throws URISyntaxException
   {
      final As3Ncss ncss = new As3Ncss( new File( "./tmp" ), new File( this.getClass().getResource( "/com/adobe/ac/ncss" ).toURI() ) );
      
      ncss.execute();
   }
}
