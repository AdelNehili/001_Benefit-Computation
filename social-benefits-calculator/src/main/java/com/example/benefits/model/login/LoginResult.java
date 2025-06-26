package com.example.benefits.model.login;

import lombok.Data;

@Data
public class LoginResult {

    private String username = "empty";
    private String mail = "empty";
    
    private String errorMsg = "";
    

    private int errorCode = -1;

    /*
    errorCode = -1 : default
    errorCode =  0 : Correct Login
    errorCode =  1 : User not found in DB
    errorCode =  2 : Incorrect password
    */
   
    public String introduce_informations(){
        String sentence = "LoginResult informations (error_msg/error_code): " + this.getErrorMsg() + ", " + this.getErrorCode()+"\n";
        sentence = sentence + "     ".repeat(5)+"(username/mail): "+ this.getUsername() + ", " + this.getMail();
        return sentence;
    }

}
