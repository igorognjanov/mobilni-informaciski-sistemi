package com.ukim.finki.pollme.model.response;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PollOptionResponse {

    private Long id;
    private String name;
    private Long pollId;
    private Boolean isDeleted;
}
