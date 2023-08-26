package com.ukim.finki.pollme.model.request;

import lombok.Data;

@Data
public class UserRequest {
    private String email;
    private String password;
    private String confirmPassword;
}
