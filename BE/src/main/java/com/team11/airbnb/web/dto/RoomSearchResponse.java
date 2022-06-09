package com.team11.airbnb.web.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class RoomSearchResponse {

    private Long id;
    private double averageGrade;
    private int numberOfReviews;
    private String imagePath;
    private String title;
    private boolean isWishList;
    private int price;

}
