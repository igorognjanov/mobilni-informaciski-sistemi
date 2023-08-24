package com.ukim.finki.pollme.model;

import javax.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(schema = "public", name = "poll_options")
public class PollOption {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    private String name;

    @ManyToOne
    @JoinColumn(name = "poll_id")
    private Poll poll;

    @Column(name = "is_deleted")
    private Boolean isDeleted;
}
