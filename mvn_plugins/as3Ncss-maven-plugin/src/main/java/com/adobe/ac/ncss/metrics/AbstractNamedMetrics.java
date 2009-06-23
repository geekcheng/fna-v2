package com.adobe.ac.ncss.metrics;

public abstract class AbstractNamedMetrics extends AbstractPackagedMetrics implements INamedMetrics
{
   private String name = "";

   public String getName()
   {
      return name;
   }

   public AbstractNamedMetrics(
         final int nonCommentStatements, final int as3DocLine, final String name, final String packageName )
   {
      super( nonCommentStatements, as3DocLine, packageName );
      this.name = name;
   }
}