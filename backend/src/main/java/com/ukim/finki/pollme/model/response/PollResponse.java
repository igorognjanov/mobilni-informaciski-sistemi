package com.ukim.finki.pollme.model.response;

import lombok.Data;

import java.util.List;

@Data
public class PollResponse {

    private Long id;
    private String pollName;
    private String questionName;
    private Boolean isDeleted;

    public PollResponse(Long id, String pollName, String questionName, Boolean isDeleted) {
        this.id = id;
        this.pollName = pollName;
        this.questionName = questionName;
        this.isDeleted = isDeleted;
    }
}
