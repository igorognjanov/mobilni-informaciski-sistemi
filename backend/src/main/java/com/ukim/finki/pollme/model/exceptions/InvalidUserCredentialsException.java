package com.ukim.finki.pollme.model.exceptions;

public class InvalidUserCredentialsException extends RuntimeException {

    public InvalidUserCredentialsException() {
        super("Invalid user credentials.");
    }
}