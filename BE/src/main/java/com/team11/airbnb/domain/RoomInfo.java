package com.team11.airbnb.domain;

import java.time.LocalTime;

import javax.persistence.Embeddable;
import lombok.Getter;

@Embeddable
@Getter
public class RoomInfo {

    private String roomType;
    private int numberOfBedroom;
    private int numberOfBed;
    private int numberOfBathroom;
    private LocalTime checkInTime;
    private LocalTime checkOutTime;

    protected RoomInfo() {
    }

    public RoomInfo(String roomType, int numberOfBedroom, int numberOfBed, int numberOfBathroom,
        LocalTime checkInTime, LocalTime checkOutTime) {
        this.roomType = roomType;
        this.numberOfBedroom = numberOfBedroom;
        this.numberOfBed = numberOfBed;
        this.numberOfBathroom = numberOfBathroom;
        this.checkInTime = checkInTime;
        this.checkOutTime = checkOutTime;
    }
}
