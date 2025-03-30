package com.app.backend.repository;

//import java.sql.Timestamp;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.app.backend.model.NearbyLocation;


public interface NearbyLocationRepository extends JpaRepository<NearbyLocation, Integer> {
    @Query("SELECT nl FROM NearbyLocation nl WHERE nl.location.id = :locationId OR nl.nearbyLocation.id = :locationId")
    List<NearbyLocation> findNearbyLocations(@Param("locationId") Integer locationId);

    // @Query("SELECT nl FROM NearbyLocation nl WHERE nl.updated_at < :timeLimit")
    // List<NearbyLocation> findOutdatedRecords(@Param("timeLimit") Timestamp timeLimit);

    @Modifying
    @Query("DELETE FROM NearbyLocation nl WHERE nl.location.id = :locationId")
    void deleteByLocationId(@Param("locationId") Integer locationId);

    @Modifying
    @Query("DELETE FROM NearbyLocation nl WHERE nl.nearbyLocation.id = :locationId")
    void deleteByNearbyLocationId(@Param("locationId") Integer locationId);
}
