package com.ukim.finki.pollme.service;

import com.ukim.finki.pollme.model.Poll;
import com.ukim.finki.pollme.model.PollOption;
import com.ukim.finki.pollme.model.request.PollOptionRequest;
import com.ukim.finki.pollme.model.response.PollOptionResponse;
import com.ukim.finki.pollme.repository.PollOptionRepository;
import org.springframework.stereotype.Service;

import java.util.Comparator;
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
        return pollOptionRepository.findById(id).orElseThrow(() ->
                new RuntimeException(String.format("PollOption with id = [%d] does not exist", id)));
    }

    public List<Long> createOrUpdate(List<PollOptionRequest> pollOptionRequests) {
        deleteInconsistentPolls(pollOptionRequests);
        List<PollOption> pollOptions = pollOptionRequests.stream().map(pollOptionRequest -> {
            PollOption pollOption;
            if (pollOptionRequest.getId() == null) {
                pollOption = new PollOption();
                pollOption.setIsDeleted(false);
            } else {
                pollOption = findById(pollOptionRequest.getId());
            }
            pollOption.setName(pollOptionRequest.getName());
            if (pollOptionRequest.getPollId() != null)
                pollOption.setPoll(pollService.findById(pollOptionRequest.getPollId()));
            return pollOption;
        }).collect(Collectors.toList());
        return pollOptionRepository.saveAll(pollOptions)
                .stream()
                .map(PollOption::getId)
                .collect(Collectors.toList());
    }

    public List<PollOptionResponse> findAllByPollId(Long pollId) {
        return pollOptionRepository
                .findAllByPoll(pollService.findById(pollId))
                .stream()
                .filter(it -> !it.getIsDeleted())
                .map((it) -> new PollOptionResponse(
                        it.getId(),
                        it.getName(),
                        it.getPoll().getId(), false))
                .sorted(Comparator.comparing(PollOptionResponse::getId))
                .collect(Collectors.toList());
    }

    public void delete(Long pollOptionId) {
        PollOption pollOption = findById(pollOptionId);
        pollOption.setIsDeleted(true);
        pollOptionRepository.save(pollOption);
    }

    public void deleteInconsistentPolls(List<PollOptionRequest> pollOptionRequests) {
        if (pollOptionRequests.isEmpty()) {
            return;
        }
        Long pollId = pollOptionRequests.stream().findFirst().get().getPollId();
        Poll poll = pollService.findById(pollId);
        List<Long> currentPollIds = pollOptionRequests.stream().map(PollOptionRequest::getId).toList();
        List<PollOption> pollOptions = pollOptionRepository.findAllByPoll(poll).stream().filter(it -> !it.getIsDeleted()).toList();
        List<PollOption> toUpdate = pollOptions.stream().filter(pollOption -> !currentPollIds.contains(pollOption.getId())).toList();
        toUpdate.forEach(pollOption -> delete(pollOption.getId()));
    }

}
