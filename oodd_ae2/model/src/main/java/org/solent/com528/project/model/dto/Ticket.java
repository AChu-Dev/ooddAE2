/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.solent.com528.project.model.dto;

import java.security.PrivateKey;
import java.util.Date;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;
import java.text.SimpleDateFormat;
import org.solent.com528.project.clientservice.impl.TicketEncoder;
import solent.ac.uk.com504.examples.ticketgate.crypto.AsymmetricCryptography;

/**
 * THIS IS A VERY BASIC TICKET - YOU WILL NEED TO IMPROVE THIS
 *
 * @author cgallen
 */
@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
public class Ticket {

    private String startStation;

    private Double cost;

    private String encryptedHash;

    private Rate rate;

    private Date validDate;
    
    private Date expiryDate;
    
    private Integer zoneCounter;

    public String getStartStation() {
        return startStation;
    }

    public void setStartStation(String startStation) {
        this.startStation = startStation;
    }

    public Double getCost() {
        return cost;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }

    public String getEncryptedHash() {
        return encryptedHash;
    }

    public void setEncryptedHash(String encryptedHash) {
        this.encryptedHash = encryptedHash;
    }

    public Rate getRate() {
        return rate;
    }

    public void setRate(Rate rate) {
        this.rate = rate;
    }

    public Date getValidDate() {
        return validDate;
    }

    public void setValidDate(Date validDate) {
        this.validDate = validDate;
    }
    
    public Date getExpiryDate(){
            return expiryDate;
    }
    
    public void setExpiryDate(Date expiryDate){
        this.expiryDate = expiryDate;
    }
    
    public void setZoneCounter(Integer zoneCounter){
        this.zoneCounter = zoneCounter;
    }
    
    public Integer getZoneCounter(){
        return zoneCounter;
    }
    
    @Override
    public String toString() {
        return "Ticket{" + "startStation=" + startStation + ", cost=" + cost + ", encryptedHash=" + encryptedHash + ", rate=" + rate + ", validDate=" + validDate + ", ExpiryDate=" + expiryDate + '}';
    }



}
