package com.team11.airbnb.web.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ArroundSpotDto {

    private String title;
    private String label;
    private int distance;
    private String imagePath;
}
