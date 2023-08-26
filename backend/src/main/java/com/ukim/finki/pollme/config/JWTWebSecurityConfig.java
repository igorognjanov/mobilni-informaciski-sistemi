package com.ukim.finki.pollme.config;

import com.ukim.finki.pollme.service.UserService;
import com.ukim.finki.pollme.web.filters.JWTAuthenticationFilter;
import com.ukim.finki.pollme.web.filters.JWTAuthorizationFilter;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true)
public class JWTWebSecurityConfig extends WebSecurityConfigurerAdapter {

    private final PasswordEncoder passwordEncoder;
    private final UserService userService;

    public JWTWebSecurityConfig(PasswordEncoder passwordEncoder, UserService userService) {
        this.passwordEncoder = passwordEncoder;
        this.userService = userService;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService (userService).passwordEncoder (passwordEncoder);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        JWTAuthenticationFilter customAuthenticationFilter = new JWTAuthenticationFilter (authenticationManagerBean (), userService, passwordEncoder);
        customAuthenticationFilter.setFilterProcessesUrl ("/api/auth/login");
        http.csrf ().disable ();
        http.sessionManagement ().sessionCreationPolicy (SessionCreationPolicy.STATELESS);
        http.authorizeRequests ().antMatchers (HttpMethod.POST, "/api/auth/register").permitAll ();
        http.authorizeRequests ().antMatchers (HttpMethod.POST, "/api/auth/login").permitAll ();
        http.authorizeRequests().antMatchers("/api/polls/**").authenticated ();
        http.authorizeRequests ().anyRequest ().permitAll ();
        http.addFilter (customAuthenticationFilter);
        http.addFilterBefore (new JWTAuthorizationFilter (authenticationManagerBean ()), UsernamePasswordAuthenticationFilter.class);
    }
}
