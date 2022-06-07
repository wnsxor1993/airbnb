package com.team11.airbnb.web.repository;

import com.team11.airbnb.domain.District;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DistrictRepository  extends JpaRepository<District,Long> {

}
