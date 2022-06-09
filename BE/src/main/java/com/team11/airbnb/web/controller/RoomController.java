package com.team11.airbnb.web.controller;

import com.team11.airbnb.web.dto.RoomDetailDto;
import com.team11.airbnb.web.dto.RoomSearchResponse;
import com.team11.airbnb.web.service.RoomService;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("rooms")
public class RoomController {

    private final RoomService roomService;

    public RoomController(RoomService roomService){
        this.roomService = roomService;
    }

    @GetMapping
    public List<RoomSearchResponse> findRooms(){
        return roomService.findAll();
    }

    @GetMapping("{id}")
    public RoomDetailDto findByRoomDetail(@PathVariable("id") Long id) throws Exception {
        return roomService.findOne(id);
    }
}
