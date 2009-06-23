package com.adobe.ac.ncss.metrics;

public abstract class AbstractAverageMetrics implements IAverageMetrics
{
   private double averageStatements;
   private double averageAs3DocLines;
   
   public double getAverageStatements()
   {
      return averageStatements;
   }

   public double getAverageAs3DocLines()
   {
      return averageAs3DocLines;
   }

   public AbstractAverageMetrics(
         final int total,
         final double totalStatements, final double totalAs3DocLines )
   {
      super();
      this.averageStatements = totalStatements / total;
      this.averageAs3DocLines = totalAs3DocLines / total;
   }
}
