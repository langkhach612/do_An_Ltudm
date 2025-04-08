package com.app.backend.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.app.backend.model.Location;
import com.app.backend.model.LocationImage;
import com.app.backend.service.LocationService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;




@RestController
@RequestMapping("/locations")
public class LocationController {
    @Autowired
    private LocationService locationService;

    @GetMapping("")
    public List<Location> getAllLocations() {
        return locationService.getAllLocations();
    }
    

    // cần sửa thêm
    @GetMapping("/search")
    public List<Location> searchLocations(@RequestParam(defaultValue = "all") String provinceId,@RequestParam(defaultValue = "all") String categoryId) {
        
        List<Location> locations;

        if (!provinceId.equals("all")) {
            locations = locationService.getLocationsByProvince(Integer.parseInt(provinceId));
        } else {
            locations = locationService.getAllLocations();
        }

        if (!categoryId.equals("all")) {
            locations = locationService.getLocationsByCategory(Integer.parseInt(categoryId), locations);
        }

        return locations;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Location> getLocationById(@PathVariable Integer id) {
        return locationService.getLocationById(id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @GetMapping("/random") //làm theo yêu cầu chủ tịch(random 6 địa điểm để trả về)
    public List<Location> getRandomLocations(){
        List<Location> locations = locationService.getAllLocations();
        List<Integer> cache = new ArrayList<>();
        List<Location> result = new ArrayList<>();
        Random rd = new Random();
        int i = 0;
        while (i < 6) {
            int index = rd.nextInt(locations.size());
            if(!cache.contains(index)){
                cache.add(index);
                result.add(locations.get(index));
                i++;
            }
        }
        return result;
    }
    
    @GetMapping("/nearby_loc/{id}")
    public ResponseEntity<List<Map<String, Object>>> getNearbyLocations(@PathVariable Integer id) {
        List<Map<String, Object>> nearbyLocations = locationService.getNearbyLocations(id);
        return ResponseEntity.ok(nearbyLocations);
    }
  

    @PostMapping("/admin/add") // dùng cho admin
    public ResponseEntity<Location> addLocation(@RequestBody Map<String, Object> requestBody ) {
        ObjectMapper objectMapper = new ObjectMapper();
        Location location = objectMapper.convertValue(requestBody.get("location"), Location.class);
        List<LocationImage> images = objectMapper.convertValue(requestBody.get("images"), new TypeReference<List<LocationImage>>() {});
        Location savedLocation = locationService.saveLocation(location, location.getCategories(), images);
        return new ResponseEntity<>(savedLocation, HttpStatus.CREATED);
    }

    @PutMapping("/admin/update/{id}") //dùng cho admin
    public ResponseEntity<Location> updateLocation(@PathVariable Integer id, @RequestBody Map<String, Object> requestBody) {
        ObjectMapper objectMapper = new ObjectMapper();
        Location locationDetails = objectMapper.convertValue(requestBody.get("location"), Location.class);
        List<LocationImage> images = objectMapper.convertValue(requestBody.get("images"), new TypeReference<List<LocationImage>>() {});
    
        Location updatedLocation = locationService.updateLocation(id, locationDetails, images);
        return updatedLocation != null ? ResponseEntity.ok(updatedLocation) : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/admin/delete/{id}") //dùng cho admin
    public ResponseEntity<Void> deleteLocation(@PathVariable Integer id) {
        locationService.deleteLocation(id);
        return ResponseEntity.noContent().build();
    }
}
