package com.team11.airbnb.domain;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
public class Host {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name ="host_id")
    private Long id;

    private String name;

    @OneToMany(mappedBy = "host")
    private List<Room> rooms = new ArrayList<>();

}
