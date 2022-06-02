package com.team11.airbnb.web.service;

import com.team11.airbnb.domain.Room;
import com.team11.airbnb.web.repository.RoomRepository;
import org.springframework.stereotype.Service;

@Service
public class RoomService {
    
    private final RoomRepository repository;

    public RoomService(RoomRepository repository) {
        this.repository = repository;
    }
    
    public Room findOne(Long roomId) throws Exception {
        return repository.findById(roomId).orElseThrow(Exception::new);
    }
}
