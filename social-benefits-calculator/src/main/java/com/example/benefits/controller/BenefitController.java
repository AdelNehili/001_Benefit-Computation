package com.example.benefits.controller;

import com.example.benefits.model.BenefitRequest;
import com.example.benefits.model.BenefitResult;
import com.example.benefits.model.CompareRequest;
import com.example.benefits.service.BenefitsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class BenefitController {

    @Autowired
    private BenefitsService benefitsService;
    //____________________________________________Basic informations____________________________________________
    @GetMapping("/")
    public String homePage() {   
        return "homepage";
    }

    @GetMapping("/about")
    public String about(Model model) {
        model.addAttribute("compareRequest", new CompareRequest());       
        return "form"; //TO CHANGE
    }
    
    @GetMapping("/contact")
    public String contact(Model model) {
        model.addAttribute("compareRequest", new CompareRequest());       
        return "form"; //TO CHANGE
    }
    
    //______________________________________________Interactions______________________________________________
    @GetMapping("/form")
    public String form(Model model) {
        model.addAttribute("compareRequest", new CompareRequest());       
        return "form";
    }
    
    @PostMapping("/compare")
    public String compare(
        @ModelAttribute CompareRequest compareRequest, 
        Model model){

        BenefitRequest requestA = compareRequest.getRequestA();
        BenefitRequest requestB = compareRequest.getRequestB();

        BenefitResult resultA = benefitsService.calculateBenefits(requestA);
        BenefitResult resultB = benefitsService.calculateBenefits(requestB);

        System.out.println("Result:");
        System.out.println("requestA (Income/NumChildren): " + requestA.getIncome() + ", " + requestA.getNumChildren());
        System.out.println("requestB (Income/NumChildren): " + requestB.getIncome() + ", " + requestB.getNumChildren() + "\n");

        model.addAttribute("requestA", requestA);
        model.addAttribute("requestB", requestB);
        model.addAttribute("resultA", resultA);
        model.addAttribute("resultB", resultB);

        return "comparison"; // comparison.html will display both
    }
}
