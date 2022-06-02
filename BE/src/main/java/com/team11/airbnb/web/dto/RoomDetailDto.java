package com.team11.airbnb.web.dto;

import com.team11.airbnb.domain.Location;
import com.team11.airbnb.domain.RoomImage;
import com.team11.airbnb.domain.RoomInfo;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder @Getter
public class RoomDetailDto {
    private String name;
    private Location location;
    private double averageGrade;
    private int numberOfReviews;
    private List<RoomImage> roomImages;
    private RoomInfo roomInfo;
    private String description;
    private int price;
    private HostDto host;
}
