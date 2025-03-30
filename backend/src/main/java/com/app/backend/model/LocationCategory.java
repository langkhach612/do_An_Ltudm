package com.app.backend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "location_categories")
public class LocationCategory {
    
    @EmbeddedId
    private LocationCategoryId id;

    @ManyToOne
    @MapsId("locationId")
    @JoinColumn(name = "location_id", nullable = false)
    private Location location;

    @ManyToOne
    @MapsId("categoryId")
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    public LocationCategory() {
    }

    public LocationCategory(Location location, Category category) {
        this.location = location;
        this.category = category;
        this.id = new LocationCategoryId(location.getId(), category.getId());
    }
}

