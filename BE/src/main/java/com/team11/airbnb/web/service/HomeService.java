package com.team11.airbnb.web.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.team11.airbnb.domain.MainEvent;
import com.team11.airbnb.domain.ThemeSpot;
import com.team11.airbnb.web.dto.MainEventDto;
import com.team11.airbnb.web.dto.ThemeSpotDto;
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
        return themeSpotList.stream()
            .map(ThemeSpotDto::new)
            .collect(Collectors.toList());
    }

    public MainEventDto getMainEventDto() throws Exception {
        MainEvent mainEvent = mainEventRepository.findById(1L).orElseThrow(Exception::new);
        return new MainEventDto(mainEvent.getTitle(), mainEvent.getLabel(),
            mainEvent.getImagePath(), mainEvent.getButtonText());
    }
}
