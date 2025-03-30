package com.app.backend.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "nearby_locations")
public class NearbyLocation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "location_id", nullable = false)
    private Location location;

    @ManyToOne
    @JoinColumn(name = "nearby_location_id", nullable = false)
    private Location nearbyLocation;

    @Column(precision = 5, scale = 2)
    private BigDecimal distance_km;

    @UpdateTimestamp
    private Timestamp updated_at;

    public NearbyLocation(){}

    public NearbyLocation(Location location, Location nearbyLocation, BigDecimal distanceKm) {
        this.location = location;
        this.nearbyLocation = nearbyLocation;
        this.distance_km = distanceKm; 
    }

}
