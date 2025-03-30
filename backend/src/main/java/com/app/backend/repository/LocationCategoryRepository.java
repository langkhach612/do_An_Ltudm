package com.app.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.app.backend.model.LocationCategory;
import com.app.backend.model.LocationCategoryId;

public interface LocationCategoryRepository extends JpaRepository<LocationCategory, LocationCategoryId> {
    
}