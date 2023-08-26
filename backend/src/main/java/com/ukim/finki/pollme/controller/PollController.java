package com.ukim.finki.pollme.controller;

import com.ukim.finki.pollme.model.Poll;
import com.ukim.finki.pollme.model.request.PollRequest;
import com.ukim.finki.pollme.model.response.PollResponse;
import com.ukim.finki.pollme.service.PollService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/polls")
public class PollController {

    PollService pollService;

    public PollController(PollService pollService) {
        this.pollService = pollService;
    }

    @GetMapping
    public List<PollResponse> findAll() {
        return pollService.findAll().stream().map((poll) -> new PollResponse(
                poll.getId(),
                poll.getPollName(),
                poll.getQuestionName(),
                poll.getIsDeleted()
        )).toList();
    }

    @PostMapping
    public Long createOrUpdate(@RequestBody PollRequest pollRequest) {
        return pollService.createOrUpdate(pollRequest);
    }

    @GetMapping("{id}")
    public PollResponse findById(@PathVariable Long id) {
        Poll poll = pollService.findById(id);
        return new PollResponse(poll.getId(),
                poll.getPollName(), poll.getQuestionName(), poll.getIsDeleted());
    }

    @DeleteMapping("{id}")
    public void delete(@PathVariable Long id) {
        pollService.delete(id);
    }

}
