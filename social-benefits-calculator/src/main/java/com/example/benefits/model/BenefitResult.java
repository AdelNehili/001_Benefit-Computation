package com.example.benefits.model;

import lombok.Data;

@Data
public class BenefitResult {
    private double benefit = 0;
    

     public void setBenefit(double current_benefit) {
        this.benefit = current_benefit;
        System.out.println(String.format(
            "Hehe setBenefit has been called with:\n - current_benefit: %s\n - this.benefit: %s",
            String.valueOf(current_benefit), String.valueOf(benefit)
        ));
    }
    public double getBenefit(){
        return benefit;
    }
}
