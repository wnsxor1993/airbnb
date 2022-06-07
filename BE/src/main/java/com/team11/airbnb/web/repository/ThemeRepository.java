package com.team11.airbnb.web.repository;

import com.team11.airbnb.domain.ThemeSpot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ThemeRepository extends JpaRepository<ThemeSpot,Long> {

}
