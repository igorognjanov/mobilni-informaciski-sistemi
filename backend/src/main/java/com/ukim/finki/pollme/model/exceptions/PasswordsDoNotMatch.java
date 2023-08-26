package com.ukim.finki.pollme.model.exceptions;

public class PasswordsDoNotMatch extends RuntimeException {

    public PasswordsDoNotMatch() {
        super("Password do not match.");
    }
}
