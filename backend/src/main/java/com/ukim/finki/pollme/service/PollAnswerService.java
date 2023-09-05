package com.ukim.finki.pollme.service;

import com.ukim.finki.pollme.model.PollAnswer;
import com.ukim.finki.pollme.repository.PollAnswerRepository;
import org.springframework.stereotype.Service;

@Service
public class PollAnswerService {

    PollAnswerRepository pollAnswerRepository;
    PollOptionService pollOptionService;
    UserService userService;

    public PollAnswerService(
            PollAnswerRepository pollAnswerRepository,
            PollOptionService pollOptionService,
            UserService userService) {
        this.pollAnswerRepository = pollAnswerRepository;
        this.pollOptionService = pollOptionService;
        this.userService = userService;
    }

    public void create(Long pollOptionId) {
        PollAnswer pollAnswer = new PollAnswer();
        pollAnswer.setPollOption(pollOptionService.findById(pollOptionId));
        pollAnswer.setUser(userService.getLoggedInUser());
        pollAnswerRepository.save(pollAnswer);
    }

}
