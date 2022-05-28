package com.team11.airbnb.domain;

import java.time.LocalDateTime;
import javax.persistence.Embeddable;

@Embeddable
public class ReservationSchedule {

    private LocalDateTime checkInDate;
    private LocalDateTime checkOutDate;

    public ReservationSchedule() {
    }

    public ReservationSchedule(LocalDateTime checkInDate, LocalDateTime checkOutDate) {
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
    }
}
