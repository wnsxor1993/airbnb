package com.team11.airbnb.web.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.team11.airbnb.domain.MainEvent;
import com.team11.airbnb.domain.ThemeSpot;
import com.team11.airbnb.web.dto.MainEventDto;
import com.team11.airbnb.web.dto.ThemeSpotDto;
import com.team11.airbnb.web.repository.DistrictRepository;
import com.team11.airbnb.web.repository.MainEventRepository;
import com.team11.airbnb.web.repository.ThemeRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HomeService {

    private final MainEventRepository mainEventRepository;
    private final ThemeRepository themeRepository;

    public List<ThemeSpotDto> getThemeSpotDtoList() {
        List<ThemeSpot> themeSpotList = themeRepository.findAll();
        List<ThemeSpotDto> themeSpotDtoList = new ArrayList<>();
        for (ThemeSpot themeSpot : themeSpotList) {
            ThemeSpotDto themeSpotDto = new ThemeSpotDto(themeSpot.getImagePath(),
                themeSpot.getTitle());
            themeSpotDtoList.add(themeSpotDto);
        }
        return themeSpotDtoList;
    }

    public MainEventDto getMainEventDto() throws Exception {
        MainEvent mainEvent = mainEventRepository.findById(1L).orElseThrow(Exception::new);
        return new MainEventDto(mainEvent.getTitle(), mainEvent.getLabel(),
            mainEvent.getImagePath(), mainEvent.getButtonText());
    }
}
