package com.team11.airbnb.web.service;

import com.team11.airbnb.domain.District;
import com.team11.airbnb.domain.MainEvent;
import com.team11.airbnb.domain.ThemeSpot;
import com.team11.airbnb.web.dto.AroundSpotDto;
import com.team11.airbnb.web.dto.HomeData;
import com.team11.airbnb.web.dto.MainEventDto;
import com.team11.airbnb.web.dto.ThemeSpotDto;
import com.team11.airbnb.web.repository.DistrictRepository;
import com.team11.airbnb.web.repository.MainEventRepository;
import com.team11.airbnb.web.repository.ThemeRepository;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class HomeService {

    private final DistrictRepository districtRepository;
    private final MainEventRepository mainEventRepository;
    private final ThemeRepository themeRepository;

    public HomeData initApplication() throws Exception {

        MainEvent mainEvent = mainEventRepository.findById(1L).orElseThrow(Exception::new);
        List<District> districtList = districtRepository.findAll();
        List<ThemeSpot> themeSpotList = themeRepository.findAll();
        MainEventDto mainEventDto = new MainEventDto(mainEvent.getTitle(), mainEvent.getLabel(),
            mainEvent.getImagePath(), mainEvent.getButtonText());
        List<AroundSpotDto> aroundSpotDtoList = new ArrayList<>();
        List<ThemeSpotDto> themeSpotDtoList = new ArrayList<>();
        for (District district : districtList) {
            AroundSpotDto aroundSpotDto = new AroundSpotDto(district.getId(), district.getName(),
                10,
                district.getImagePath());
            aroundSpotDtoList.add(aroundSpotDto);
        }
        for (ThemeSpot themeSpot : themeSpotList) {
            ThemeSpotDto themeSpotDto = new ThemeSpotDto(themeSpot.getImagePath(),
                themeSpot.getTitle());
            themeSpotDtoList.add(themeSpotDto);
        }
        return new HomeData(mainEventDto, aroundSpotDtoList, themeSpotDtoList);
    }
}
