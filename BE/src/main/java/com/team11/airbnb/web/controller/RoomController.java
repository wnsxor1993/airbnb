package com.team11.airbnb.web.controller;

import com.team11.airbnb.web.dto.RoomDetailDto;
import com.team11.airbnb.web.service.RoomService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping
public class RoomController {

    private final RoomService roomService;

    public RoomController(RoomService roomService){
        this.roomService = roomService;
    }

    @GetMapping("{id}")
    public RoomDetailDto findByRoomDetail(@PathVariable("id") Long id) throws Exception {
        return roomService.findOne(id);
    }
}
