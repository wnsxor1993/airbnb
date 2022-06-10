package com.team11.airbnb.web.dto;

import com.team11.airbnb.domain.ThemeSpot;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ThemeSpotDto {

    private String imagePath;
    private String title;

	public ThemeSpotDto(ThemeSpot themeSpot) {
		this.imagePath = themeSpot.getImagePath();
		this.title = themeSpot.getTitle();
	}
}
