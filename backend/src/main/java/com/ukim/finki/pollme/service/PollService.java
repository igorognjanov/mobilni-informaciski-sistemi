package com.ukim.finki.pollme.service;

import com.ukim.finki.pollme.model.Poll;
import com.ukim.finki.pollme.repository.PollRepository;
import com.ukim.finki.pollme.model.request.PollRequest;
import org.springframework.stereotype.Service;

@Service
public class PollService {

    PollRepository pollRepository;
    UserService userService;

    public PollService(
            PollRepository pollRepository,
            UserService userService) {
        this.pollRepository = pollRepository;
        this.userService = userService;
    }

    public Poll findById(Long id) {
        return pollRepository.findById (id).orElseThrow (() -> new RuntimeException (
                String.format ("Poll with id = [%d] does not exist.", id)));
    }

    public Long createOrUpdate(PollRequest pollRequest) {
        Poll poll;
        if (pollRequest.getId () == null) {
            poll = new Poll ();
            poll.setIsDeleted (false);
//            poll.setCreatedBy (userService.getLoggedInUser ());
        } else {
            poll = findById (pollRequest.getId ());
        }
        poll.setPollName (pollRequest.getPollName ());
        poll.setQuestionName (pollRequest.getQuestionName ());
        return pollRepository.save (poll).getId ();
    }

    public void delete(Long id) {
        Poll poll = findById (id);
        poll.setIsDeleted (true);
        pollRepository.save (poll);
    }


}
