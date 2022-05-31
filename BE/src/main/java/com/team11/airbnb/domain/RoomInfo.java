package com.team11.airbnb.domain;

import javax.persistence.Embeddable;
import lombok.Getter;

@Embeddable
@Getter
public class RoomInfo {

    private String roomType;
    private String numberOfBedroom;
    private String numberOfBed;
    private String checkInTime;
    private String checkOutTime;

    protected RoomInfo() {
    }

    public RoomInfo(String roomType, String numberOfBedroom, String numberOfBed, String checkInTime,
        String checkOutTime) {
        this.roomType = roomType;
        this.numberOfBedroom = numberOfBedroom;
        this.numberOfBed = numberOfBed;
        this.checkInTime = checkInTime;
        this.checkOutTime = checkOutTime;
    }
}
