package com.ukim.finki.pollme.controller;

import com.ukim.finki.pollme.model.request.PollOptionRequest;
import com.ukim.finki.pollme.model.response.PollOptionResponse;
import com.ukim.finki.pollme.service.PollOptionService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/poll-options")
public class PollOptionController {

    PollOptionService pollOptionService;

    public PollOptionController(PollOptionService pollOptionService) {
        this.pollOptionService = pollOptionService;
    }

    @PostMapping
    public List<Long> createOrUpdate(@RequestBody List<PollOptionRequest> pollOptionRequests) {
        return pollOptionService.createOrUpdate (pollOptionRequests);
    }

    @GetMapping("{pollId}")
    public List<PollOptionResponse> findAllByPollId(@PathVariable Long pollId) {
        return pollOptionService.findAllByPollId (pollId);
    }

    @DeleteMapping("{pollOptionId}")
    public void delete(@PathVariable Long pollOptionId) {
        pollOptionService.delete(pollOptionId);
    }
}
