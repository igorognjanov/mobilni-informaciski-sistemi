package com.ukim.finki.pollme.controller;

import com.ukim.finki.pollme.model.Role;
import com.ukim.finki.pollme.model.User;
import com.ukim.finki.pollme.model.request.UserRequest;
import com.ukim.finki.pollme.service.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/register")
    public User registerUser(@RequestBody UserRequest userRequest) {
        return userService.register (
                userRequest.getEmail (),
                userRequest.getPassword (),
                userRequest.getConfirmPassword (),
                Role.ROLE_ADMIN
        );
    }

    @ExceptionHandler(Exception.class)
    public Map<String, String> handler(Exception e) {
        return Map.of ("Error", e.getMessage ());
    }

}
