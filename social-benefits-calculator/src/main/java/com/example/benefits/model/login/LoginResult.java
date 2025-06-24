package com.example.benefits.model.login;

import lombok.Data;

@Data
public class LoginResult {
    private String errorMsg = "";
    private int errorCode = -1;

    public String introduce_informations(){
        String sentence = "LoginResult informations (error_msg/error_code): " + this.getErrorMsg() + ", " + this.getErrorCode();
        return sentence;
    }

}
