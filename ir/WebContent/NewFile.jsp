<%@page import="ir.IRhandling"%>
<%@page import="ir.Checker"%>
<%@page import="ir.Remote"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<HTML>
    <HEAD>
        <TITLE>Using Buttons</TITLE>
    </HEAD>

    <BODY>
        <% 
        Checker thread = new Checker();
        thread.start();
         Remote remote1 = new Remote("harman","C:/Users/jesus/eclipse-workspace/ir/src/ir/harman.lircd.conf");
		 IRhandling ir = new IRhandling(remote1);
            //if(request.getParameter("buttonName") != null) {
            if(request.getParameter("buttonName")!=null && request.getParameter("buttonName").equals("standby")) {
            IRhandling.standby();
            }
            else if(request.getParameter("buttonName")!=null && request.getParameter("buttonName").equals("mute")) {
            	ir.mute();
            }
            else if(request.getParameter("buttonName")!=null && request.getParameter("buttonName").equals("volumeup")) {
            	ir.volUp();
            }
            else if(request.getParameter("buttonName")!=null && request.getParameter("buttonName").equals("volumedown")) {
            	ir.volDown();
            }
            else if(request.getParameter("buttonName")!=null && request.getParameter("buttonName").equals("vcr1")) {
            	ir.vcr1();
            }
            else if(request.getParameter("buttonName")!=null && request.getParameter("buttonName").equals("vcr2")) {
            	ir.vcr2();
            	
            	
            }
        %>
           
            
        

        <FORM NAME="form1" METHOD="POST">
            <INPUT TYPE="HIDDEN" NAME="buttonName">
            <INPUT TYPE="BUTTON" VALUE="Standby" ONCLICK="standby()">
            <INPUT TYPE="BUTTON" VALUE="Mute" ONCLICK="mute()">
            <INPUT TYPE="BUTTON" VALUE="Volume up" ONCLICK="volUp()">
            <INPUT TYPE="BUTTON" VALUE="Volume down" ONCLICK="volDown()">
            <INPUT TYPE="BUTTON" VALUE="Vcr1" ONCLICK="vcr1()">
            <INPUT TYPE="BUTTON" VALUE="Vcr2" ONCLICK="vcr2()">
        </FORM>

        <SCRIPT LANGUAGE="JavaScript">
            <!--
            function standby()
            {
                document.form1.buttonName.value = "standby"
                form1.submit()
         
            }
            function mute()
            {
                document.form1.buttonName.value = "mute"
                form1.submit()
         
            }   
            function volUp()
            {
                document.form1.buttonName.value = "volumeup"
                form1.submit()
            }
            function volDown()
            {
                document.form1.buttonName.value = "volumedown"
                form1.submit()
            }   
            function vcr1()
            {
                document.form1.buttonName.value = "vcr1"
                form1.submit()
            }   
            function vcr2()
            {
                document.form1.buttonName.value = "vcr2"
                form1.submit()
            }   
            // --> 
        </SCRIPT>
    </BODY>
</HTML>