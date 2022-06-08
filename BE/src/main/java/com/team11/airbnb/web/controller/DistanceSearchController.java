package com.team11.airbnb.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.team11.airbnb.openapi.DistanceInfoResponse;
import com.team11.airbnb.openapi.DistrictSearchService;
import com.team11.airbnb.openapi.Position;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/distance")
@Slf4j
public class DistanceSearchController {

    private final DistrictSearchService districtSearchService;

    public DistanceSearchController(DistrictSearchService districtSearchService) {
        this.districtSearchService = districtSearchService;
    }

    @GetMapping("/times")
    public ResponseEntity<List<DistanceInfoResponse>> getDurations(Position position)
        throws JsonProcessingException {
        log.info("position={}, {}", position.getX(), position.getY());
        List<DistanceInfoResponse> distanceInfoResponses = districtSearchService.searchDistrictInfo(position);

            return ResponseEntity.ok(distanceInfoResponses);

    }

}
