package com.adobe.ac.ncss.metrics;

public class AverageClassMetrics
      extends AbstractAverageMetrics
{
   private final double averageFunctions;

   public AverageClassMetrics(
         final int nonCommentStatements, final int as3DocLine, final int functions, final int totalClassNumber )
   {
      super( totalClassNumber, nonCommentStatements, as3DocLine );
      averageFunctions = functions / totalClassNumber;
   }

   public double getAverageFunctions()
   {
      return averageFunctions;
   }
}
