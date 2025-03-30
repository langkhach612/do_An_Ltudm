package com.app.backend.model;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
public class LocationCategoryId implements Serializable {
    private Integer locationId;
    private Integer categoryId;

    // public LocationCategoryId(Integer locationId, Integer categoryId) {
    //     this.locationId = locationId.longValue();
    //     this.categoryId = categoryId.longValue();
    // }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        LocationCategoryId that = (LocationCategoryId) o;
        return Objects.equals(locationId, that.locationId) && Objects.equals(categoryId, that.categoryId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(locationId, categoryId);
    }
}

