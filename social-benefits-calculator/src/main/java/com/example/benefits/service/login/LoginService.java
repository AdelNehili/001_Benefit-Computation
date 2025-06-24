package com.example.benefits.service.login;

import com.example.benefits.model.benefit.BenefitRequest;
import com.example.benefits.model.benefit.BenefitResult;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    @Autowired
    private KieContainer kieContainer;

    public BenefitResult calculateBenefits(BenefitRequest request) {
        KieSession kieSession = kieContainer.newKieSession("benefitSession");
        BenefitResult result = new BenefitResult();
        kieSession.insert(request);
        kieSession.insert(result);
        kieSession.fireAllRules();
        kieSession.dispose();
        return result;
    }
}