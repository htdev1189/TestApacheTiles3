<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<html>
<head>
    <title><tiles:getAsString name="title"/></title>
</head>
<body>
    <!-- Chèn header -->
    <tiles:insertAttribute name="header" />

    <!-- Nội dung chính -->
    <div>
        <tiles:insertAttribute name="body" />
    </div>

    <!-- Chèn footer -->
    <tiles:insertAttribute name="footer" />
</body>
</html>
