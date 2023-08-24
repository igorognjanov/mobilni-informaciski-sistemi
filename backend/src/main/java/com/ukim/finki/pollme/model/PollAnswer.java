package com.ukim.finki.pollme.model;

import javax.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(schema = "public", name = "poll_answers")
public class PollAnswer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "poll_option_id")
    private PollOption pollOption;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

}
