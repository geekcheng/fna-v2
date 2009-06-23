package com.adobe.ac.ncss.metrics;

public class FunctionMetrics
      extends AbstractNamedMetrics
{
   public FunctionMetrics(
         final int nonCommentStatements, final int as3DocLine, final String name, final String packageName )
   {
      super( nonCommentStatements, as3DocLine, name, packageName );
   }

   @Override
   public String getFullName()
   {
      return getPackageName() + "." + getName();
   }

   @Override
   public String getContreteXml()
   {
      return "";
   }

   @Override
   public String getMetricsName()
   {
      return "function";
   }
}
