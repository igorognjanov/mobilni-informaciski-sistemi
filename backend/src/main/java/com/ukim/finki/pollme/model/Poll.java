package com.ukim.finki.pollme.model;

import javax.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(schema = "public", name = "polls")
public class Poll {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "poll_name")
    private String pollName;

    @Column(name = "question_name")
    private String questionName;

    @Column(name = "is_deleted")
    private Boolean isDeleted;

}
