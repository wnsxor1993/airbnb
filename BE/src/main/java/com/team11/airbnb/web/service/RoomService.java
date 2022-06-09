package com.team11.airbnb.web.service;

import com.team11.airbnb.domain.Host;
import com.team11.airbnb.domain.Room;
import com.team11.airbnb.web.dto.HostDto;
import com.team11.airbnb.web.dto.RoomDetailDto;
import com.team11.airbnb.web.dto.RoomSearchResponse;
import com.team11.airbnb.web.repository.RoomRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class RoomService {

    private final RoomRepository repository;

    public RoomService(RoomRepository repository) {
        this.repository = repository;
    }

    public RoomDetailDto findOne(Long roomId) throws Exception {
        Room room = repository.findById(roomId).orElseThrow(Exception::new);
        Host host = room.getHost();
        return RoomDetailDto.builder().
            name(room.getName()).location(room.getLocation()).
            averageGrade(room.getAverageGrade()).
            numberOfReviews(room.getReviews().size()).
            roomImages(List.copyOf(room.getRoomImages())).
            roomInfo(room.getRoomInfo()).
            description(room.getDescription()).
            price(room.getPrice()).
            host(new HostDto(host.getId(), host.getName(), host.isSuperHost(),
                host.getProfileImagePath())).build();
    }

    public List<RoomSearchResponse> findAll() {
        List<Room> rooms = repository.findAll();
        List<RoomSearchResponse> roomSearchResponses = new ArrayList<>();

        for (Room room : rooms) {
            roomSearchResponses.add(new RoomSearchResponse(room.getId(),room.getAverageGrade(),room.getReviews().size(), room.getRoomImages().get(0).getImagePath(), room.getName(), false, room.getPrice()));
        }

        return roomSearchResponses;
    }
}
