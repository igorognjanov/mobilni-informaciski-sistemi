package com.ukim.finki.pollme.model.request;

import lombok.Data;

@Data
public class PollRequest {

    private final Long id;
    private final String pollName;
    private final String questionName;

}
