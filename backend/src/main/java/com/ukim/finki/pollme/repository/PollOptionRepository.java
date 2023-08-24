package com.ukim.finki.pollme.repository;

import com.ukim.finki.pollme.model.Poll;
import com.ukim.finki.pollme.model.PollOption;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PollOptionRepository extends JpaRepository<PollOption, Long> {

    List<PollOption> findAllByPoll(Poll poll);

}
