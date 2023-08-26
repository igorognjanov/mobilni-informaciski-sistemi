package com.ukim.finki.pollme.service;

import com.ukim.finki.pollme.model.PollAnswer;
import com.ukim.finki.pollme.model.request.PollAnswerRequest;
import com.ukim.finki.pollme.repository.PollAnswerRepository;
import org.springframework.stereotype.Service;

@Service
public class PollAnswerService {

    PollAnswerRepository pollAnswerRepository;
    PollOptionService pollOptionService;

    public PollAnswerService(
            PollAnswerRepository pollAnswerRepository,
            PollOptionService pollOptionService) {
        this.pollAnswerRepository = pollAnswerRepository;
        this.pollOptionService = pollOptionService;
    }

//    public Long create(PollAnswerRequest pollAnswerRequest) {
//        PollAnswer pollAnswer = new PollAnswer ();
//        pollAnswer.setPollOption (pollOptionService.findById (pollAnswerRequest.getPollOptionId ()));
//        pollAnswer.setUser ();
//    }

}
