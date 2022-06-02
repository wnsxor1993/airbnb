package com.team11.airbnb.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@Getter
public class Room {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @JsonIgnore
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "host_id")
    private Host host;

    @Embedded
    private Location location;

    private Double averageGrade;

    @OneToMany(mappedBy = "room")
    private List<Review> reviews = new ArrayList<>();

    @OneToMany(mappedBy = "room")
    @JsonManagedReference
    private List<RoomImage> roomImages = new ArrayList<>();

    @Embedded
    private RoomInfo roomInfo;
    private String name;
    private String description;
    private int price;
}
