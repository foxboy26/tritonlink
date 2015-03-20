# Preparation #
Go to [Downloads](http://code.google.com/p/tritonlink/downloads/list) page to get the tomcat, svn and jdbc.
MS SQL Sever 2012 Express can be downloaded from [here](https://www.microsoft.com/betaexperience/pd/SQLEXPWT/enus/). (Choose the 64-bit version)

**Note:** For all the installation below, make sure that you run the program as an administrator to avoid the issue caused by authority.

# Tomcat #
  * Install apache tomcat server. Choose all the default settings.
  * To make sure that tomcat service is running, open a browser and type localhost:8080 in the address bar. If you see the tomcat homepage, it turns out that the server is working.
  * To start/stop the service, just right click the icon in system tray.

# Eclipse #
The following instructions will help you setup the JSP project in Eclipse.
  * Check whether your Eclipse contains WTP (Web Tool Platform). Go to Window->Preferences->Server->Runtime Environment to see if you can add a new server. Follow this [link](http://www.vogella.com/articles/EclipseWTP/article.html#configuration) to see if you can setup the server. Contact me if you cannot.
  * To create a JSP project, go to File->New->New project->Web->Dynamic Web Project. Type the _Project name_ and choose the _Target runtime_ as the server you just setup. It should be Apache Tomcat v7.0. Keep rest of settings as default.
  * After the creation of the project, you will see a list of folders. Put your website page under the _WebContent_ folder.
  * Create a new file `helloWorld.jsp` and put the following code in it.
```
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hello World - JSP tutorial</title>
</head>
<body>
    <%= "Hello World!" %>
</body>
</html>
```
  * Right click on `helloWorld.jsp` and select from context menu 'Run As' --> 'Run on Server'
  * Make sure that you have stopped the tomcat service before you run the program in Eclipse. That is because Eclipse will try to start the service itself, there will be port conflict:(
  * Follow [this](http://www.srccodes.com/p/article/2/JSP-Hello-World-Program-using-Eclipse-IDE-and-Tomcat-web-server) link if you need more detail instructions.

# MS SQL Server #


# JDBC #
  * Extract the


# SVN #
  * 