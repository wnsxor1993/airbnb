package com.team11.airbnb.web.dto;

import java.util.ArrayList;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class HomeData {

    private MainEventDto mainEventDto;
    private List<AroundSpotDto> aroundSpotDto = new ArrayList<>();
    private List<ThemeSpotDto> themeSpotDto = new ArrayList<>();

}
