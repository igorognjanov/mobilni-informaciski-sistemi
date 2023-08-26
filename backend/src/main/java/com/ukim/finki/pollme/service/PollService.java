package com.ukim.finki.pollme.service;

import com.ukim.finki.pollme.model.Poll;
import com.ukim.finki.pollme.repository.PollRepository;
import com.ukim.finki.pollme.model.request.PollRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PollService {

    PollRepository pollRepository;

    public PollService(PollRepository pollRepository) {
        this.pollRepository = pollRepository;
    }

    public List<Poll> findAll(){
        return this.pollRepository.findAll();
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
