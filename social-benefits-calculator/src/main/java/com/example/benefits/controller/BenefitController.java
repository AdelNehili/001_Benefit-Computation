package com.example.benefits.controller;

import com.example.benefits.model.BenefitRequest;
import com.example.benefits.model.BenefitResult;
import com.example.benefits.service.BenefitsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class BenefitController {

    @Autowired
    private BenefitsService benefitsService;

    @GetMapping("/")
    public String homePage(Model model) {
        model.addAttribute("benefitRequest", new BenefitRequest());
        return "form";
    }

    @PostMapping("/calculate")
    public String calculate(@ModelAttribute BenefitRequest request, Model model) {
        BenefitResult result = benefitsService.calculateBenefits(request);
        model.addAttribute("income", request.getIncome());
        model.addAttribute("numChildren", request.getNumChildren());
        model.addAttribute("benefit", result.getBenefit());
        return "result";
    }
}
