package com.adobe.ac.ncss.metrics;

public abstract class AbstractPackagedMetrics implements IPackagedMetrics
{
   private int nonCommentStatements = 0;
   private int as3DocLine = 0;
   private String packageName = "";

   public AbstractPackagedMetrics(
         final int nonCommentStatements, final int as3DocLine, final String packageName )
   {
      super();
      this.nonCommentStatements = nonCommentStatements;
      this.as3DocLine = as3DocLine;
      this.packageName = packageName;
   }

   public String getPackageName()
   {
      return packageName;
   }

   public int getNonCommentStatements()
   {
      return nonCommentStatements;
   }

   public int getAs3DocLine()
   {
      return as3DocLine;
   }

   abstract public String getFullName();

   abstract public String getMetricsName();

   abstract public String getContreteXml();

   public String toXmlString()
   {
      return "<" + getMetricsName() + "><name>" + getFullName() + "</name><ccn>0</ccn><ncss>" + nonCommentStatements + "</ncss><javadocs>" + as3DocLine + "</javadocs>" + getContreteXml() + "</" + getMetricsName() + ">";
   }
}
