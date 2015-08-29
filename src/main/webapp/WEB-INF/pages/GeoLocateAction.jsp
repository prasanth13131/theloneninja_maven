<%@ page language="java" %>
    <%@ page import="com.loneninja.geo.*" %>
    <%
    String ajaxreq=request.getParameter("ajaxReq");
    if(ajaxreq!=null&&ajaxreq.equalsIgnoreCase("getLatLong")){
    	String ipid=request.getParameter("ajaxipid");
    	GeoLocate gl = new GeoLocate();
    	response.setContentType("text/html");
    	response.setHeader("Cache-Control", "no-cache");
    	response.getWriter().write(gl.fetchLatLong(ipid,"jdbc:oracle:thin:@113.128.164.178:1521:XE"));
    }
    
    
    %>