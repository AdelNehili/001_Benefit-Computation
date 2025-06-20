package com.example.benefits.model;

public class CompareRequest {
    private BenefitRequest requestA = new BenefitRequest();
    private BenefitRequest requestB = new BenefitRequest();

    public BenefitRequest getRequestA() {
        return requestA;
    }

    public void setRequestA(BenefitRequest requestA) {
        this.requestA = requestA;
    }

    public BenefitRequest getRequestB() {
        return requestB;
    }

    public void setRequestB(BenefitRequest requestB) {
        this.requestB = requestB;
    }
}
