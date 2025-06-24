package com.example.benefits.model.login;

import lombok.Data;

@Data
public class LoginRequest {
    private String identifier; //Can be Mail or Username (to check with the Drools rules)
    private String password;

    public String introduce_informations(){
        String sentence = "LoginRequest informations (identifier/password): " + this.getIdentifier() + ", " + this.getPassword();
        return sentence;
    }
}
