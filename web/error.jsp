<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.sql.SQLException" %><%-- attribute isErrorPage="true" lets container to pass exceptions here  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
    <title>Error</title>
</head>
<body>
    <%-- you can use standart "exception" entity only at error pages --%>
<%
    String message = exception.getMessage();
%>
<h1><%=message%></h1>
    <%
        for (StackTraceElement ste : exception.getStackTrace()) { %>
            <p><%=ste.toString()%></p>
        <%}
    %>
</body>
</html>
