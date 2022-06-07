package com.team11.airbnb.web.repository;

import com.team11.airbnb.domain.MainEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MainEventRepository extends JpaRepository<MainEvent, Long> {

}
