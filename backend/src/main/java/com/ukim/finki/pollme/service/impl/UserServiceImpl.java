package com.ukim.finki.pollme.service.impl;

import com.ukim.finki.pollme.model.Role;
import com.ukim.finki.pollme.model.User;
import com.ukim.finki.pollme.model.exceptions.InvalidArgumentException;
import com.ukim.finki.pollme.model.exceptions.PasswordsDoNotMatch;
import com.ukim.finki.pollme.repository.UserRepository;
import com.ukim.finki.pollme.service.UserService;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder encoder;

    public UserServiceImpl(UserRepository userRepository, PasswordEncoder encoder) {
        this.userRepository = userRepository;
        this.encoder = encoder;
    }

    @Override
    public User register(String username, String password, String repeatPassword, Role role) {
        if (username == null || password == null || username.isEmpty () || password.isEmpty () )
            throw new InvalidArgumentException ();
        if (!password.equals (repeatPassword))
            throw new PasswordsDoNotMatch ();
        User user = new User (username, encoder.encode (password), role);
        return userRepository.save (user);
    }

    @Override
    public User getLoggedInUser() {
        Authentication authentication = SecurityContextHolder.getContext ().getAuthentication ();
        boolean isLoggedIn = authentication.isAuthenticated ();
        String username = null;
        if (isLoggedIn) {
            username = SecurityContextHolder.getContext().getAuthentication ().getPrincipal ().toString();
        }
        return getUserByUsername(username);
    }

    @Override
    public User getUserByUsername(String username) {
        return userRepository.findByUsername (username).orElseThrow (
                () -> new UsernameNotFoundException (username)
        );
    }

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        return getUserByUsername(s);
    }
}

