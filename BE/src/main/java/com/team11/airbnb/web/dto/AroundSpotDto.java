package com.team11.airbnb.web.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class AroundSpotDto {

    private Long id;
    private String title;;
    private String imagePath;
    private String distance;
    private String time;

}
