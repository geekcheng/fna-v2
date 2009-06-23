package com.adobe.ac.lcds.assemblers;

import java.lang.reflect.Method;
import java.util.Iterator;
import java.util.List;

public class AssemblerUtils
{
   /**
    * Pretty print the parameters list coming from a fill or a count method.
    * 
    * @param paramterers list of parameters
    * @return comma separated parameters list
    */
   static public String printParameterList(
         final List paramterers )
   {
      String res = "";

      for ( Iterator iterator = paramterers.iterator(); iterator.hasNext(); )
      {
         Object parameter = iterator.next();

         res += parameter.toString();

         if ( iterator.hasNext() )
         {
            res += ", ";
         }
      }

      return res;
   }

   /**
    * Pretty print a changes list. By example, if the description field and the
    * version field have been changed, this function would print on System.out:
    * description was <description> => <description2> version was <1> => <2>
    * 
    * @param newVersion new version of the item
    * @param previousVersion old version of the item
    * @param changes List of attributes name which have been changed
    */
   static public void printChanges(
         final Object newVersion, final Object previousVersion,
         final List changes )
   {
      for ( Object item : changes )
      {
         final String attributeToBeChanged = item.toString();

         try
         {
            Method getValueMethod = null;

            try
            {
               getValueMethod = previousVersion.getClass().getMethod(
                     "is"
                           + capitalize( attributeToBeChanged ) );
            }
            catch ( NoSuchMethodException e )
            {
            }

            if ( getValueMethod == null )
            {
               getValueMethod = previousVersion.getClass().getMethod(
                     "get"
                           + capitalize( attributeToBeChanged ) );
            }

            final Object oldValue = getValueMethod.invoke( previousVersion );
            final Object newValue = getValueMethod.invoke( newVersion );

            System.out.println( "   "
                  + attributeToBeChanged + " was <" + oldValue + "> => <"
                  + newValue + ">" );

         }
         catch ( Exception e )
         {
            e.printStackTrace();
         }
      }
   }

   /**
    * Convert a list of string to an array of strings.
    * 
    * @param parameters
    * @return
    */
   public static String[] convertListToArray(
         final List parameters )
   {
      String[] array = new String[ parameters.size() ];

      for ( int i = 0; i < parameters.size(); i++ )
      {
         array[ i ] = ( String ) parameters.get( i );
      }
      return array;
   }

   /**
    * Capitalize a the first letter of the given string.
    * 
    * @param s
    * @return
    */
   public static String capitalize(
         final String s )
   {
      if ( s.length() == 0 )
         return s;
      return s.substring(
            0, 1 ).toUpperCase()
            + s.substring( 1 );
   }
}
