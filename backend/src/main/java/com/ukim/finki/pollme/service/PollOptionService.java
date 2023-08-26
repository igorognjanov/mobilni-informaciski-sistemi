package com.ukim.finki.pollme.service;

import com.ukim.finki.pollme.model.PollOption;
import com.ukim.finki.pollme.model.request.PollOptionRequest;
import com.ukim.finki.pollme.model.response.PollOptionResponse;
import com.ukim.finki.pollme.repository.PollOptionRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PollOptionService {

    PollOptionRepository pollOptionRepository;
    PollService pollService;

    public PollOptionService(
            PollOptionRepository pollOptionRepository,
            PollService pollService) {
        this.pollOptionRepository = pollOptionRepository;
        this.pollService = pollService;
    }

    public PollOption findById(Long id) {
        return pollOptionRepository.findById (id).orElseThrow (() ->
                new RuntimeException (String.format ("PollOption with id = [%d] does not exist", id)));
    }

    public List<Long> createOrUpdate(List<PollOptionRequest> pollOptionRequests) {
        List<PollOption> pollOptions = pollOptionRequests.stream ().map (pollOptionRequest -> {
            PollOption pollOption;
            if (pollOptionRequest.getId () == null) {
                pollOption = new PollOption ();
                pollOption.setIsDeleted (false);
            } else {
                pollOption = findById (pollOptionRequest.getId ());
            }
            pollOption.setName (pollOptionRequest.getName ());
            if (pollOptionRequest.getPollId () != null)
                pollOption.setPoll (pollService.findById (pollOptionRequest.getPollId ()));
            return pollOption;
        }).collect (Collectors.toList ());
        return pollOptionRepository.saveAll (pollOptions)
                .stream ()
                .map (PollOption::getId)
                .collect (Collectors.toList ());
    }

    public List<PollOptionResponse> findAllByPollId(Long pollId) {
        return pollOptionRepository
                .findAllByPoll (pollService.findById (pollId))
                .stream ()
                .map ((it) -> new PollOptionResponse (
                        it.getId (),
                        it.getName (),
                        it.getPoll ().getId (),
                        it.getIsDeleted ()))
                .collect (Collectors.toList ());
    }

    public void delete(Long pollOptionId) {
        PollOption pollOption = findById (pollOptionId);
        pollOption.setIsDeleted (true);
        pollOptionRepository.save (pollOption);
    }

}
