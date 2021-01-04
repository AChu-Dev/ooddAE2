<%-- 
    Document   : ticketGate
    Created on : 1 Jan 2021, 17:54:25
    Author     : Adam Chu
--%>

<%@page import="org.solent.com528.project.model.dto.Ticket"%>
<%@page import="org.solent.com528.project.impl.webclient.WebClientObjectFactory"%>
<%@page import="org.solent.com528.project.model.dto.Station"%>
<%@page import="org.solent.com528.project.model.dao.StationDAO"%>
<%@page import="org.solent.com528.project.model.service.ServiceFacade"%>
<%@page import="org.solent.com528.project.impl.service.rest.client.ClientObjectFactoryImpl"%>
<%@page import="java.util.Date"%>
<%@page import="org.solent.com528.project.clientservice.impl.TicketEncoderImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Boolean decodedTicketBool = false;
    String Logging = "";
    String encodedTicketString = "";

    try {
        if (encodedTicketString != null || encodedTicketString.length() != 0) {
            decodedTicketBool = TicketEncoderImpl.validateTicket(encodedTicketString);
            if (decodedTicketBool == true) {
                Ticket decodedTicket = new Ticket();
                ServiceFacade serviceFacade = (ServiceFacade) WebClientObjectFactory.getServiceFacade();
                StationDAO stationDAO = serviceFacade.getStationDAO();
                Station station = stationDAO.findByName(decodedTicket.getStartStation());
                //if(Math.max(, station.getZone()) == Math.min(station.getZone(), ))
                Logging = "Ticket is correct, Gate Opening";
            } else {
                Logging = "Ticket is out of Service";
            }
        }
    } catch (Exception Err) {
        Logging = Err.getMessage();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gate</title>
    </head>
    <body>
        <h1>Ticket Gate</h1>
        <h1><%= Logging%></h1>
        <p>Please Input Ticket Here:</p>
        <form action="./ticketCreate.jsp"  method="post">
            <table>    
            <tr>
                <td>Starting Station:</td>
                <td><input type="text" name="arrivalStation"></td>
            </tr>
            </table>
            <textarea <textarea rows="15" cols="60" value="" name="encodedTicketString" ></textarea>
            <button type="submit">Validate Ticket</button>
        </form>
    </body>
</html>
