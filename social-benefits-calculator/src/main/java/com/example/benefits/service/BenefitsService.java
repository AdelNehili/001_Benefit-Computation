package com.example.benefits.service;

import com.example.benefits.model.BenefitRequest;
import com.example.benefits.model.BenefitResult;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BenefitsService {
    @Autowired
    private KieContainer kieContainer;

    public BenefitResult calculateBenefits(BenefitRequest request) {
        KieSession kieSession = kieContainer.newKieSession();
        BenefitResult result = new BenefitResult();
        kieSession.insert(request);
        kieSession.insert(result);
        kieSession.fireAllRules();
        kieSession.dispose();
        return result;
    }
}
