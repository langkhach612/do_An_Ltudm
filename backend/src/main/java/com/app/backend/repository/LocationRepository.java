package com.app.backend.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.lang.NonNull;

import com.app.backend.model.Location;


public interface LocationRepository extends JpaRepository<Location, Integer> {

    @EntityGraph(attributePaths = {"province", "images"})
    List<Location> findByProvinceId(Integer provinceId);

    @EntityGraph(attributePaths = {"province", "images"})
    Location findByName(String name);

    @EntityGraph(attributePaths = {"province", "images"})
    @NonNull
    List<Location> findAll();

    @EntityGraph(attributePaths = {"province", "images"})
    @NonNull
    Optional<Location> findById(@NonNull Integer id);


    @Query("SELECT l FROM Location l LEFT JOIN FETCH l.images WHERE l.id = :id")
    Optional<Location> findByIdWithImages(@Param("id") Integer id);
}
