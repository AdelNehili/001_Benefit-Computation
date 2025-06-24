package com.example.benefits.model.login;

import lombok.Data;

@Data
public class LoginRequest {
    private String username;
    private String password;
    private String mail;
}
