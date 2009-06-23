call mvn clean install 
echo '=============================================== mvn clean install site' 
cd flex_remoted_objects
call mvn site
echo '=============================================== flex_remoted_object site' 
cd ..
cd flex_app
call mvn site
echo '=============================================== flex_app site' 
cd ..
cd java_core
call mvn site
echo '=============================================== java_core site' 
cd ..
cd java_webapp
call mvn site
echo '=============================================== java_webapp site' 
cd ..
call mvn site
call mvn site:deploy
echo '===============================================  site deploy' 
