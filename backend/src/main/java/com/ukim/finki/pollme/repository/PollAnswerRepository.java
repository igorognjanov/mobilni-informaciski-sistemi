package com.ukim.finki.pollme.repository;

import com.ukim.finki.pollme.model.PollAnswer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PollAnswerRepository extends JpaRepository<PollAnswer, Long> {
}
