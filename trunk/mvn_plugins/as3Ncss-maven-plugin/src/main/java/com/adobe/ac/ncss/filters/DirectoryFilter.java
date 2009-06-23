package com.adobe.ac.ncss.filters;

import java.io.File;
import java.io.FileFilter;

public class DirectoryFilter implements FileFilter
{
   public boolean accept(
         final File file )
   {
      return file.isDirectory();
   }
}
