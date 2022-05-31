package com.team11.airbnb.domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
public class Room {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "host_id")
    private Host host;

    @Embedded
    private Address address;

    private Double averageGrade;


    @OneToMany(mappedBy = "room")
    @JsonManagedReference
    private List<RoomImage> roomImages = new ArrayList<>();

    @Embedded
    private RoomInfo roomInfo;
    private String name;
    private String description;
    private int price;
}
