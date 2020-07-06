package com.mark.microservice.moudle.controller;

import org.springframework.stereotype.Controller;

@Controller
public class HelloController {


    public String hello() {
        return "Hello micro service is running";
    }
}
