package com.adobe.ac.ncss.metrics;

public class ClassMetrics
      extends AbstractNamedMetrics
{
   private int functions = 0;

   public ClassMetrics(
         final int nonCommentStatements, final int as3DocLine, final int functions, final String name, final String packageName )
   {
      super( nonCommentStatements, as3DocLine, name, packageName );

      this.functions = functions;
   }

   public int getFunctions()
   {
      return functions;
   }

   @Override
   public String getFullName()
   {
      return getPackageName() + "." + getName();
   }

   @Override
   public String getContreteXml()
   {
      return "<functions>" + functions + "</functions>";
   }

   @Override
   public String getMetricsName()
   {
      return "object";
   }
}
