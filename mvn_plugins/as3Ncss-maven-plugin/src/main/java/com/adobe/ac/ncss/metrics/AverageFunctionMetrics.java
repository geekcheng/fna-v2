package com.adobe.ac.ncss.metrics;

public class AverageFunctionMetrics extends AbstractAverageMetrics
{
   public AverageFunctionMetrics(
         final int nonCommentStatements, final int as3DocLine, final int totalFunctions )
   {
      super( totalFunctions, nonCommentStatements, as3DocLine );
   }
}
