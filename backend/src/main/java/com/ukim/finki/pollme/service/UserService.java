package com.ukim.finki.pollme.service;

import com.ukim.finki.pollme.model.Role;
import com.ukim.finki.pollme.model.User;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface UserService extends UserDetailsService {

    User register (String username, String password, String repeatPassword, Role role);

    User getUserByUsername(String username);

    User getLoggedInUser();

}

