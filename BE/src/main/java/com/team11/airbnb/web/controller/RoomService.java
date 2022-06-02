package com.team11.airbnb.web.controller;

import com.team11.airbnb.domain.Room;
import org.springframework.stereotype.Service;

@Service
public class RoomService {
    
    private final RoomRepository repository;

    public RoomService(RoomRepository repository) {
        this.repository = repository;
    }
    
    public Room findOne(Long roomId) throws Exception {
        return repository.findById(roomId).orElseThrow(() -> new Exception());
    }
}
