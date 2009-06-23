package com.adobe.ac.ncss.metrics;

public interface IPackagedMetrics extends IMetrics
{
   String toXmlString();
   String getPackageName();
   int getNonCommentStatements();
   int getAs3DocLine();
   String getFullName();
   String getMetricsName();
   String getContreteXml();
}
