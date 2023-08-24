package com.ukim.finki.pollme.model.request;

import lombok.Data;

@Data
public class PollOptionRequest {
    private Long id;
    private String name;
    private Long pollId;

}
