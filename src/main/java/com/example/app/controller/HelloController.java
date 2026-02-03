package com.example.app.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello() {
        return "Hello Akshay! from CI/CD Spring Boot App is live.";
    }

    @GetMapping("/status")
    public String status() {
        return "Hi Akshay! Application is running status is healthy!!!";
    }
}
