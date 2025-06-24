package com.example.benefits.service.login;

import com.example.benefits.model.login.LoginRequest;
import com.example.benefits.model.login.LoginResult;


import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    @Autowired
    private KieContainer kieContainer;

    public LoginResult manageLogin(LoginRequest request) {
        KieSession kieSession = kieContainer.newKieSession("LoginSession");

        LoginResult result = new LoginResult();
        kieSession.insert(request);
        kieSession.insert(result);

        kieSession.fireAllRules();
        kieSession.dispose();
        return result;
    }
}