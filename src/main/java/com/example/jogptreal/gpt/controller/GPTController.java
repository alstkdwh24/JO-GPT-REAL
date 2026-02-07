package com.example.jogptreal.gpt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/home")
public class GPTController {

    @GetMapping("/GPT-Home")
    public String GPTHome(){
        return "home/GPT-Home";
    }


}
