package com.team11.airbnb.openapi;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class DistrictSearchService {

    private String kakaokey = "a1d0ecbd325633346f2938e35d6db4d4";

    public List<DistanceInfoResponse> searchDistrictInfo(Position position)
        throws JsonProcessingException {
        District[] districts = District.values();
        List<DistanceInfoResponse> distanceInfoResponses = new ArrayList<>();
        for (District district : districts) {
            DistanceInfo distanceInfo = calculateDistanceAndTime(position, district.getLongtitude(),
                district.getLatitude());
            String distance = String.valueOf(distanceInfo.getDistanceByKiloMeters());
            String duration = String.valueOf(distanceInfo.getTimeByMinutes());
            distanceInfoResponses.add(
                new DistanceInfoResponse(district.name(), distance, duration));
        }

        return distanceInfoResponses;
    }

    private DistanceInfo calculateDistanceAndTime(Position position, double destinationX,
        double destinationY) throws
        JsonProcessingException {
        RestTemplate restTemplate = new RestTemplate();
        String url = getUrl(position.getX(), position.getY(), destinationX, destinationY);
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET,
            new HttpEntity<>(getHeaders()), String.class);

        ObjectMapper objectMapper = new ObjectMapper();

        JsonNode body = objectMapper.readTree(response.getBody());
        JsonNode routes = body.get("routes");
        JsonNode route = routes.get(0);
        int resultCode = route.get("result_code").asInt();
        if (resultCode != 0) {
            return new DistanceInfo(-999, -999);
        }
        JsonNode summary = route.get("summary");
        double distanceByMeters = summary.get("distance").asDouble();
        double timeBySeconds = summary.get("duration").asDouble();

        return new DistanceInfo(distanceByMeters, timeBySeconds);
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
        return UriComponentsBuilder.fromHttpUrl(url)
            .queryParam("origin", origin)
            .queryParam("destination", destination)
            .queryParam("summary", true)
            .encode()
            .toUriString();
    }
}
