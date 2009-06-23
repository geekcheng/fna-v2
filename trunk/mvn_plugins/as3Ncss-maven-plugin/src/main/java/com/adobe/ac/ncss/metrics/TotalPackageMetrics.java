package com.adobe.ac.ncss.metrics;

public class TotalPackageMetrics implements ITotalMetrics
{
   private int totalStatements;
   private int totalAs3DocLine;
   private int totalFunctions;
   private int totalClasses;

   public TotalPackageMetrics(
         final int totalStatements, final int totalAs3DocLine, final int totalFunctions, final int totalClasses )
   {
      super();
      this.totalStatements = totalStatements;
      this.totalAs3DocLine = totalAs3DocLine;
      this.totalFunctions = totalFunctions;
      this.totalClasses = totalClasses;
   }

   public int getTotalStatements()
   {
      return totalStatements;
   }

   public int getTotalAs3DocLine()
   {
      return totalAs3DocLine;
   }

   public int getTotalFunctions()
   {
      return totalFunctions;
   }

   public int getTotalClasses()
   {
      return totalClasses;
   }

}
