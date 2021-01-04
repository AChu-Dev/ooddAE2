<%-- 
    Document   : ticketCreate.jsp
    Created on : 31 Dec 2020, 20:53:40
    Author     : Adam Chu
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="org.solent.com528.project.impl.webclient.WebClientObjectFactory"%>
<%@page import="org.solent.com528.project.model.dto.PricingDetails"%>
<%@page import="org.solent.com528.project.model.dao.PriceCalculatorDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.solent.com528.project.clientservice.impl.TicketEncoderImpl"%>
<%@page import="org.solent.com528.project.clientservice.impl.TicketEncoder"%>
<%@page import="java.util.Date"%>
<%@page import="org.solent.com528.project.model.service.ServiceFacade"%>
<%@page import="org.solent.com528.project.model.dto.Ticket" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //Inintalising DAO/Facade Level Objects
    ServiceFacade serviceFacade = (ServiceFacade) WebClientObjectFactory.getServiceFacade();
    PriceCalculatorDAO priceCalculatorDAO = serviceFacade.getPriceCalculatorDAO();
    TicketEncoder ticketEncoder = new TicketEncoderImpl();
    
    //Creating Local Variables
    Ticket ticket = new Ticket();
    Date constructionDate = new Date();
    Double cost = null;
    String costString = null;
    
    //Null Checking on the Form Elements
    String errorLogging = "";
    String encodedTicketString = "";
    String zoneCounterString = request.getParameter("zoneCounter");
    if (zoneCounterString == null || zoneCounterString.isEmpty()) {
        zoneCounterString = "1";
    }

    String startPointString = request.getParameter("startPoint");
    if (startPointString == null || startPointString.isEmpty()) {
        startPointString = "Placeholder Please Change";
    }

    String validDateString = request.getParameter("validDate");
    if (validDateString == null || validDateString.isEmpty()) {
        Date currentDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm");
        validDateString = dateFormat.format(currentDate);
    }

    String expiryDateString = request.getParameter("expiryDate");
    if (expiryDateString == null || expiryDateString.isEmpty()) {
        Date initDate = new Date(new Date().getTime() + 1000 * 60 * 60 * 24);
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm");
        expiryDateString = dateFormat.format(initDate);
    }
    
    if (cost == null) {
        constructionDate.parse(validDateString);
        double rate = priceCalculatorDAO.getPricePerZone(constructionDate);
        cost =  rate * Integer.valueOf(zoneCounterString);
        costString = String.format("%.2f", cost);
    }
    
    //Ticket Creation
    try {
            //trigger card payment third party function
            ticket.setCost(cost);
            constructionDate.parse(validDateString);
            ticket.setValidDate(constructionDate);
            constructionDate.parse(expiryDateString);
            ticket.setExpiryDate(constructionDate);
            int constructionInt = Integer.valueOf(zoneCounterString);
            ticket.setZoneCounter(constructionInt);
            encodedTicketString = TicketEncoderImpl.encodeTicket(ticket);
    } catch (Exception Err) {
        errorLogging = Err.getMessage();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Ticket</title>
    </head>
    <body>
        <h1><%= errorLogging%></h1>
        <form action="./ticketCreate.jsp"  method="post">
            <table>
                <tr>
                    <td>How many zones the Ticket is Valid For:</td>
                    <td><input type="text" name="zoneCounter" value="<%=zoneCounterString%>"></td>
                </tr>
                <tr>
                    <td>Starting Station:</td>
                    <td><input type="text" name="startPoint" value="<%=startPointString%>"></td>
                </tr>
                <tr>
                    <td>Validity Date/Time:</td>
                    <td><input type="text" name="validDate" value="<%=validDateString%>"></td>
                </tr>
                <tr>
                    <td>Expiry Date/Time:</td>
                    <td><input type="text" name="expiryDate" value="<%=expiryDateString%>"></td>
                </tr>
                <tr>
                    <td>Cost: £<%= costString %></td>
                    <td></td>
                    <td><input type="button" name="cardPayment" value="Pay Using Card Swipe"></td>
                </tr>
            </table>
            <button type="submit">Create Ticket</button>
        </form> 
        <h1>Ticket ID Below</h1>
        <textarea rows="15" cols="80" value="<%=encodedTicketString%>" ></textarea>

    </body>
</html>
</body>
</html>
