package com.team11.airbnb.domain;

import java.time.LocalTime;

import javax.persistence.Embeddable;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import lombok.Getter;

@Embeddable
@Getter
public class RoomInfo {

    @Enumerated(EnumType.STRING)
    private RoomType roomType;
    private int numberOfBedroom;
    private int numberOfBed;
    private int numberOfBathroom;
    private int capacity;
    private LocalTime checkInTime;
    private LocalTime checkOutTime;

    protected RoomInfo() {
    }

    public RoomInfo(RoomType roomType, int numberOfBedroom, int numberOfBed, int numberOfBathroom,
        int capacity, LocalTime checkInTime, LocalTime checkOutTime) {
        this.roomType = roomType;
        this.numberOfBedroom = numberOfBedroom;
        this.numberOfBed = numberOfBed;
        this.numberOfBathroom = numberOfBathroom;
        this.capacity = capacity;
        this.checkInTime = checkInTime;
        this.checkOutTime = checkOutTime;
    }

}
