package com.ukim.finki.pollme.controller;

import com.ukim.finki.pollme.service.PollAnswerService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/poll-answers")
public class PollAnswerController {

    private final PollAnswerService pollAnswerService;

    public PollAnswerController(PollAnswerService pollAnswerService) {
        this.pollAnswerService = pollAnswerService;
    }

    @PostMapping("{pollOptionId}")
    public void create(@PathVariable Long pollOptionId) {
        pollAnswerService.create (pollOptionId);
    }

}
