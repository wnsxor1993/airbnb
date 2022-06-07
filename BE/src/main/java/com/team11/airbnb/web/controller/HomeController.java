package com.team11.airbnb.web.controller;

import com.team11.airbnb.web.dto.HomeData;
import com.team11.airbnb.web.service.HomeService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {

    private final HomeService homeService;

    public HomeController(HomeService homeService){
        this.homeService = homeService;
    }

    @GetMapping("/home")
    public HomeData home() throws Exception {
        return homeService.initApplication();
    }

}
