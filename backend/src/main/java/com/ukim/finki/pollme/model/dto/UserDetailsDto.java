package com.ukim.finki.pollme.model.dto;

import com.ukim.finki.pollme.model.Role;
import com.ukim.finki.pollme.model.User;
import lombok.Data;

@Data
public class UserDetailsDto {

    private String username;
    private Role role;

    public static UserDetailsDto of(User user) {
        UserDetailsDto details = new UserDetailsDto ();
        details.username = user.getUsername ();
        details.role = user.getRole ();
        return details;
    }

}
