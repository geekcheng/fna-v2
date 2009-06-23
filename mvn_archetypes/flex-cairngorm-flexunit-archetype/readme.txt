An Adobe Consulting Maven Archetype - flex-cairngorm-flexunit-archetype
=======================================================================

version 1.1 release note:
==========================
This version is based on 
* flex-mojos maven plugin (2.0-alpha3)
* the latest maven archetype plugins (2.0-alpha-3, as well)
* the latest FlexUnit 0.9 (from opensource.adobe.com)

 It also corrects a few issues there were with the 1.0 version
 
 
Installation:
================== 
 test this archetype by
* installing it
{code}
mvn install
{code}

Test it:
=============
* running it somewhere else on your disk to create a test project
{code}
mvn -e org.apache.maven.plugins:maven-archetype-plugin:2.0-alpha-3:generate -DarchetypeGroupId=com.adobe.ac -DarchetypeArtifactId=flex-cairngorm-flexunit-archetype -DarchetypeVersion=1.1  -DgroupId=com.droff -DartifactId=flex-cairngorm-flexunit-sample
{code}

hosted at : http://code.google.com/p/fna/



