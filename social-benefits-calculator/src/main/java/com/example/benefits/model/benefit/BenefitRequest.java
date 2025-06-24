package com.example.benefits.model.benefit;

import lombok.Data;

@Data
public class BenefitRequest {
    private int age;
    private double income = 0;
    private double cadastralIncome = 0;

    private int numChildren = 0;
    private int numOrphanedChildren;

    private String status; //Employed or Unemployed
    private int durationMonths; //Same status's duration
    private double lastSalary; //lastSalary value
    
}
