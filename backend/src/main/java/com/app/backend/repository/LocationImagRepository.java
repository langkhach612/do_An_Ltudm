package com.app.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.app.backend.model.Location;
import com.app.backend.model.LocationImage;

import jakarta.transaction.Transactional;

import java.util.List;


public interface LocationImagRepository extends JpaRepository<LocationImage, Integer> {
    List<LocationImage> findByLocation(Location location);
    List<LocationImage> findByLocationId(Integer locationId);
    // xóa ảnh của một địa điểm theo id của ảnh đó
    @Modifying
    @Transactional
    @Query("DELETE FROM LocationImage li WHERE li.id = :imageId")
    void deleteById(Integer imageId);
}