net stop SJRF

xcopy C:\myws2017\tango\tango-web\target\tango-web-1.0-SNAPSHOT\* D:\Java\apache-tomcat-7.0.26-SJRF\webapps\tango-web\* /E /Y /C /F /I
xcopy D:\Java\apache-tomcat-7.0.26-SJRF\webapps_bak\tango-web.properties D:\Java\apache-tomcat-7.0.26-SJRF\webapps\tango-web\WEB-INF\classes\tango-web.properties  /E /Y /C /F /I

net start SJRF

net stop SJRF-BJ

xcopy C:\myws2017\tango\tango-web\target\tango-web-1.0-SNAPSHOT\* D:\Java\apache-tomcat-7.0.26-SJRF-BJ\webapps\tango-web-bj\* /E /Y /C /F /I
xcopy D:\Java\apache-tomcat-7.0.26-SJRF-BJ\webapps_bak\tango-web-bj.properties D:\Java\apache-tomcat-7.0.26-SJRF-BJ\webapps\tango-web-bj\WEB-INF\classes\tango-web.properties  /E /Y /C /F /I
xcopy D:\Java\apache-tomcat-7.0.26-SJRF-BJ\webapps_bak\log4j-bj.properties D:\Java\apache-tomcat-7.0.26-SJRF-BJ\webapps\tango-web-bj\WEB-INF\classes\log4j.properties  /E /Y /C /F /I


xcopy C:\myws2017\tango\tango-web\target\tango-web-1.0-SNAPSHOT\* D:\Java\apache-tomcat-7.0.26-SJRF-BJ\webapps\tango-web-sz\* /E /Y /C /F /I
xcopy D:\Java\apache-tomcat-7.0.26-SJRF-BJ\webapps_bak\tango-web-sz.properties D:\Java\apache-tomcat-7.0.26-SJRF-BJ\webapps\tango-web-sz\WEB-INF\classes\tango-web.properties  /E /Y /C /F /I
xcopy D:\Java\apache-tomcat-7.0.26-SJRF-BJ\webapps_bak\log4j-sz.properties D:\Java\apache-tomcat-7.0.26-SJRF-BJ\webapps\tango-web-bj\WEB-INF\classes\log4j.properties  /E /Y /C /F /I

net start SJRF-BJ