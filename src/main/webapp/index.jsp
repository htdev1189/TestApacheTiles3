<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/style.css" rel="stylesheet">
</head>
<body>
	<div class="container">
		<h1>tích hợp Apache tiles vào Spring Mvc</h1>
		<ul>
			<li>
				<p>Dường như đã hết hỗ trợ với những spring 6x, nên đang dùng tạm bản spring 5.3.23</p>
				<p>Nếu muốn dùng spring 5 thì tomcat lại chạy về 9.</p>
				<p>JDK chuyển về phiên bản 17 chứ ko phải 21</p>
				<p>Thư viện Spring 5.3.23 và Lites 3.0 đã tải về hết trong lib</p>
				<p> link tải Apache lites 3.0 -> <a href="https://archive.apache.org/dist/tiles/3.0.8/" target="_blank">https://archive.apache.org/dist/tiles/3.0.8/</a>
				</p>
				<p>Lỗi xml download <a href="https://stackoverflow.com/questions/77252112/downloading-from-external-resources-is-disabled-in-hibernate-dtd">https://stackoverflow.com/questions/77252112/downloading-from-external-resources-is-disabled-in-hibernate-dtd</a></p>
			</li>
			<li>
				Cấu hình Spring MVC
				<div class="block1">
					<h3>wWEB-INF/spring-servlet.xml</h3>
<pre>
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
           http://www.springframework.org/schema/beans/spring-beans.xsd
           http://www.springframework.org/schema/context
           http://www.springframework.org/schema/context/spring-context.xsd
           http://www.springframework.org/schema/mvc
           http://www.springframework.org/schema/mvc/spring-mvc.xsd"&gt;

    &lt;context:annotation-config&gt;&lt;/context:annotation-config&gt;
    &lt;context:component-scan base-package="controller"&gt;&lt;/context:component-scan&gt;
    &lt;mvc:annotation-driven&gt;&lt;/mvc:annotation-driven&gt;
    &lt;mvc:resources location="/css/" mapping="/css/*"&gt;&lt;/mvc:resources&gt;

    &lt;!-- 
    &lt;bean id="viewResolver" class="org.springframework.web.servlet.view.UrlBasedViewResolver"&gt;
        &lt;property name="viewClass" value="org.springframework.web.servlet.view.JstlView"/&gt;
        &lt;property name="prefix" value="/views/"/&gt;
        &lt;property name="suffix" value=".jsp"/&gt;
    &lt;/bean&gt;
    --&gt;

    &lt;!-- Tiles config --&gt;
    &lt;bean id="tilesConfigurer"
          class="org.springframework.web.servlet.view.tiles3.TilesConfigurer"&gt;
        &lt;property name="definitions"&gt;
            &lt;list&gt;
                &lt;value&gt;/WEB-INF/tiles.xml&lt;/value&gt;
            &lt;/list&gt;
        &lt;/property&gt;
    &lt;/bean&gt;

    &lt;!-- View resolver --&gt;
    &lt;bean class="org.springframework.web.servlet.view.UrlBasedViewResolver"&gt;
        &lt;property name="viewClass" value="org.springframework.web.servlet.view.tiles3.TilesView" /&gt;
        &lt;property name="order" value="0" /&gt;
    &lt;/bean&gt;

&lt;/beans&gt;
</pre>

				</div>
<div class="block1">
	<h3>wWEB-INF/web.xml</h3>
<pre>
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xmlns="http://java.sun.com/xml/ns/javaee"
         xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
                             http://java.sun.com/xml/ns/javaee/web-app_3_1.xsd"
         version="4.0"&gt;

  &lt;display-name&gt;TestApacheTiles&lt;/display-name&gt;

  &lt;welcome-file-list&gt;
    &lt;welcome-file&gt;index.jsp&lt;/welcome-file&gt;
  &lt;/welcome-file-list&gt;

  &lt;!-- Triển khai Spring MVC --&gt;
  &lt;servlet&gt;
    &lt;servlet-name&gt;spring&lt;/servlet-name&gt;
    &lt;servlet-class&gt;org.springframework.web.servlet.DispatcherServlet&lt;/servlet-class&gt;
    &lt;load-on-startup&gt;1&lt;/load-on-startup&gt;
  &lt;/servlet&gt;

  &lt;servlet-mapping&gt;
    &lt;servlet-name&gt;spring&lt;/servlet-name&gt;
    &lt;url-pattern&gt;/&lt;/url-pattern&gt;
  &lt;/servlet-mapping&gt;

&lt;/web-app&gt;
</pre>

</div>		
				
			</li>


			<li>
				Cấu hình Apache Tiles
				<div class="block1">
					<h3>WEB-INF/tiles.xml</h3>
<pre>
&lt;?xml version="1.0" encoding="UTF-8" ?&gt;
&lt;!DOCTYPE tiles-definitions PUBLIC
       "-//Apache Software Foundation//DTD Tiles Configuration 3.0//EN"
       "http://tiles.apache.org/dtds/tiles-config_3_0.dtd"&gt;

&lt;tiles-definitions&gt;
    &lt;definition name="baseLayout" template="/WEB-INF/views/layouts/layout.jsp"&gt;
        &lt;put-attribute name="title" value="" /&gt;
        &lt;put-attribute name="header" value="/WEB-INF/views/common/header.jsp" /&gt;
        &lt;put-attribute name="body" value="" /&gt;
        &lt;put-attribute name="footer" value="/WEB-INF/views/common/footer.jsp" /&gt;
    &lt;/definition&gt;

    &lt;definition name="home" extends="baseLayout"&gt;
        &lt;put-attribute name="title" value="Home Page" /&gt;
        &lt;put-attribute name="body" value="/WEB-INF/views/home.jsp" /&gt;
    &lt;/definition&gt;
&lt;/tiles-definitions&gt;
</pre>

				</div>
			</li>
			
			
			<li>
				<div class="block1">
					<h3>Quy trình hoạt động -- giả sử gọi tới đường dẫn /home</h3>
					<div class="block2">
					
<pre>
	- b1: Spring sử dụng TilesView để tìm definition trong tiles.xml</br>
		- ke thua baseLayout</br>
		- chèn title = "Home Page"</br>
		- chèn body = /WEB-INF/views/home.jsp</br>
	- b2: Tiles dùng baseLayout template</br>
		- Sẽ render file layout chính: layout.jsp</br>
	- b3: File layout.jsp hiển thị</br>
		- <tiles:getAsString name="title" /> lấy "Home Page" được định nghĩa ở file tiles.xml</br>
		- <tiles:insertAttribute name="body" /> sẽ chèn noi dung home.jsp vào đây, tương tự như header và footer</br>
</pre>
					</div>					
				</div>				
			</li>
		</ul>
	</div>
		
</body>
</html>