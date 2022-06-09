package com.team11.airbnb.web.controller;

import java.util.List;

import com.team11.airbnb.openapi.Position;
import com.team11.airbnb.web.dto.AroundSpotDto;
import com.team11.airbnb.web.dto.MainEventDto;
import com.team11.airbnb.web.dto.ThemeSpotDto;
import com.team11.airbnb.web.service.DistrictSearchService;
import com.team11.airbnb.web.dto.HomeData;
import com.team11.airbnb.web.service.HomeService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class HomeController {

    private final HomeService homeService;
    private final DistrictSearchService districtSearchService;

    @GetMapping("/home")
    public HomeData home(Position position) throws Exception {
        MainEventDto mainEventDto = homeService.getMainEventDto();
        List<ThemeSpotDto> themeSpotDtoList = homeService.getThemeSpotDtoList();
        List<AroundSpotDto> aroundSpotDtos = districtSearchService.searchDistrictInfo(position);
        return new HomeData(mainEventDto, aroundSpotDtos, themeSpotDtoList);
    }

}
