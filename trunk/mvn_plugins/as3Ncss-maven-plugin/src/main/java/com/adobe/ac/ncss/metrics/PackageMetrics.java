package com.adobe.ac.ncss.metrics;

public class PackageMetrics
      extends AbstractPackagedMetrics
{
   private int functions = 0;
   private int classes = 0;

   public int getFunctions()
   {
      return functions;
   }

   public int getClasses()
   {
      return classes;
   }

   public PackageMetrics(
         final int nonCommentStatements, final int as3DocLine, final int functions, final int classes, final String packageName )
   {
      super( nonCommentStatements, as3DocLine, packageName );
      this.functions = functions;
      this.classes = classes;
   }

   @Override
   public String getFullName()
   {
      return getPackageName();
   }

   @Override
   public String getContreteXml()
   {
      return "<functions>" + functions + "</functions><classes>" + classes + "</classes><javadoc_lines>0</javadoc_lines><single_comment_lines>0</single_comment_lines><multi_comment_lines>0</multi_comment_lines>";
   }

   @Override
   public String getMetricsName()
   {
      return "package";
   }
}