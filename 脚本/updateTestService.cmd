net stop tomcat7_dev

xcopy E:\myws\dts\Edbao\WebContent\WEB-INF\classes\com\taobao\* E:\tomcat-dev-7.0.42\webapps\WebContent\WEB-INF\classes\com\taobao\* /E /Y /C /F /I

net start tomcat7_dev
