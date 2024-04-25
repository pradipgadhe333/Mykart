package com.learn.mycart.helper;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class GEmailSender {
    
    public boolean sendEmail(String to, String from, String subject, String text)
    {
        boolean flag=false;
        
        //logic
        //smtp properties
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com"); // Replace with your SMTP server address
        properties.put("mail.smtp.port", "587"); 
        
        final String username="mykartservice";
        final String password="ppiswexotmydtych"; //App password generated in gmail
        
        //create session object
        Session s=Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password); 
            }
            
        });
        
        try {
            
            //Create a MimeMessage object and set the email details
            Message message=new MimeMessage(s);
            
            message.setFrom(new InternetAddress(from));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);
            message.setText(text);
            
            //send the email
            Transport.send(message);
            
            flag=true;
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return flag;
    }
    
}