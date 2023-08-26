package com.ukim.finki.pollme.web.filters;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ukim.finki.pollme.config.JWTAuthConstants;
import com.ukim.finki.pollme.model.dto.UserDetailsDto;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;

public class JWTAuthorizationFilter extends BasicAuthenticationFilter {

    public JWTAuthorizationFilter(AuthenticationManager authenticationManager) {
        super (authenticationManager);
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
        String header = request.getHeader (JWTAuthConstants.HEADER_STRING);
        if (header == null || !header.startsWith (JWTAuthConstants.TOKEN_PREFIX)) {
            chain.doFilter (request, response);
            return;
        }
        String user = JWT.require (Algorithm.HMAC256 (JWTAuthConstants.SECRET.getBytes ()))
                .build ()
                .verify (header.replace (JWTAuthConstants.TOKEN_PREFIX, ""))
                .getSubject ();

        if (user == null) {
            return;
        }

        UserDetailsDto userDetailDto = new ObjectMapper ().readValue (user, UserDetailsDto.class);
        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken (userDetailDto.getUsername (),
                "", Collections.singletonList (userDetailDto.getRole ()));
        SecurityContextHolder.getContext ().setAuthentication (token);
        chain.doFilter (request, response);
    }
}
