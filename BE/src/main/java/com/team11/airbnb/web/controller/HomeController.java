package com.team11.airbnb.web.controller;

import com.team11.airbnb.openapi.DistrictSearchService;
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
    public HomeData home() throws Exception {
        return homeService.initApplication();
    }

}
