package com.team11.airbnb.openapi;

import java.time.Duration;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.digidemic.unitof.UnitOf;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class DistrictSearchService {

    private String kakaokey = "a1d0ecbd325633346f2938e35d6db4d4";

    public List<DistanceInfoResponse> searchDistrictInfo(Position position)
        throws JsonProcessingException {
        District[] districts = District.values();
        List<DistanceInfoResponse> distanceInfoResponses = new ArrayList<>();
        for (District district : districts) {
            Map<String, String> result = calculateDistanceAndTime(position, district.getLongtitude(),
                district.getLatitude());
            String distance = result.get("distance");
            String time = result.get("time");
            distanceInfoResponses.add(
                new DistanceInfoResponse(district.name(), distance, time));
        }

        return distanceInfoResponses;
    }

    private Map<String, String> calculateDistanceAndTime(Position position, double destinationX,
        double destinationY) throws
        JsonProcessingException {
        RestTemplate restTemplate = new RestTemplate();
        String url = getUrl(position.getX(), position.getY(), destinationX, destinationY);
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET,
            new HttpEntity<>(getHeaders()), String.class);

        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, String> result = new HashMap<>();

        JsonNode body = objectMapper.readTree(response.getBody());
        JsonNode routes = body.get("routes");
        JsonNode route = routes.get(0);
        int resultCode = route.get("result_code").asInt();
        log.info("result code = {}", resultCode);
        if (resultCode != 0) {
            result.put("time", "-999");
            result.put("distance", "-999");
            return result;
        }
        JsonNode summary = route.get("summary");
        double distanceByMeters = summary.get("distance").asDouble();
        Long timeBySeconds = summary.get("duration").asLong();
        log.warn("distance = {}, time  = {}", distanceByMeters, timeBySeconds);


        Duration duration = Duration.ofSeconds(timeBySeconds);
        String timeByMinutes = String.valueOf(duration.toMinutes());
        UnitOf.Length distanceUnitConverter = new UnitOf.Length().fromMeters(distanceByMeters);
        String distanceByKilometers = String.valueOf(distanceUnitConverter.toKilometers());
        result.put("time", timeByMinutes);
        result.put("distance", distanceByKilometers);

        return result;
    }

    private MultiValueMap<String, String> getHeaders() {
        MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
        headers.add("Host", "apis-navi.kakaomobility.com");
        headers.add("Authorization", "KakaoAK " + kakaokey);

        return headers;
    }

    private String getUrl(double originX, double originY, double destinationX,
        double destinationY) {
        String url = "https://apis-navi.kakaomobility.com/v1/directions";
        String origin = originX + "," + originY;
        String destination = destinationX + "," + destinationY;
        log.info("origin = {}, destination = {}", origin, destination);
        return UriComponentsBuilder.fromHttpUrl(url)
            .queryParam("origin", origin)
            .queryParam("destination", destination)
            .queryParam("summary", true)
            .encode()
            .toUriString();
    }
}
