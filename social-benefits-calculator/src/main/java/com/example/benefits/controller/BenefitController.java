package com.example.benefits.controller;


//Login Packages
import com.example.benefits.model.login.LoginRequest;
import com.example.benefits.model.login.LoginResult;
import com.example.benefits.service.login.LoginService;

//Benefit Packages
import com.example.benefits.model.benefit.BenefitRequest;
import com.example.benefits.model.benefit.BenefitResult;
import com.example.benefits.model.benefit.CompareRequest;
import com.example.benefits.service.benefit.BenefitsService;

//Basic Packages
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class BenefitController {

    @Autowired
    private BenefitsService benefitsService;
    @Autowired
    private LoginService loginService;
    
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
    
    //______________________________________________Login & Dashboard______________________________________________
    @GetMapping("/login")
    public String login(Model model) {
        model.addAttribute("LoginRequest", new LoginRequest());       
        return "login";
    }

    @PostMapping("/login")
    public String login(
        @ModelAttribute LoginRequest loginRequest,
        Model model) {

        LoginResult loginResult = loginService.manageLogin(loginRequest);

        System.out.println("Result:");
        System.out.println(loginRequest.introduce_informations());
        System.out.println(loginResult.introduce_informations());
        

        model.addAttribute("loginResult", loginResult);       
        return "dashboard";
    }
    

    //______________________________________________Form and Request comparison______________________________________________
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

        return "comparison"; // comparison.html will display both requests
    }
}
