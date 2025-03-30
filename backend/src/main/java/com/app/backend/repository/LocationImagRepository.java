package com.app.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.app.backend.model.Location;
import com.app.backend.model.LocationImage;
import java.util.List;


public interface LocationImagRepository extends JpaRepository<LocationImage, Integer> {
    List<LocationImage> findByLocation(Location location);
}
