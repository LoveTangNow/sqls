net stop SJRF
xcopy C:\myws2017\tango\tango-web\target\tango-web-1.0-SNAPSHOT\* D:\Java\apache-tomcat-7.0.26-SJRF\webapps\tango-web\* /E /Y /C /F /I
xcopy D:\Java\apache-tomcat-7.0.26-SJRF\webapps_bak\tango-web.properties D:\Java\apache-tomcat-7.0.26-SJRF\webapps\tango-web\WEB-INF\classes\tango-web.properties  /E /Y /C /F /I
net start SJRF

net stop SJRF-BJ
xcopy C:\myws2017\tango\tango-web\target\tango-web-1.0-SNAPSHOT\* D:\Java\apache-tomcat-7.0.26-SJRF-BJ\webapps\tango-web\* /E /Y /C /F /I
xcopy D:\Java\apache-tomcat-7.0.26-SJRF-BJ\webapps_bak\tango-web.properties D:\Java\apache-tomcat-7.0.26-SJRF-BJ\webapps\tango-web\WEB-INF\classes\tango-web.properties  /E /Y /C /F /I
net start SJRF-BJ
