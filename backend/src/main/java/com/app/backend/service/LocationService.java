package com.app.backend.service;

import java.math.BigDecimal;
// import java.math.RoundingMode;
// import java.sql.Timestamp;
// import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
// import org.springframework.web.client.RestTemplate;

import com.app.backend.model.Category;
import com.app.backend.model.Location;
import com.app.backend.model.LocationCategory;
import com.app.backend.model.LocationImage;
// import com.app.backend.model.NearbyLocation;
import com.app.backend.repository.*;
// import com.fasterxml.jackson.databind.JsonNode;
// import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.transaction.Transactional;

@Service
public class LocationService {

    @Autowired
    private LocationRepository locationRepository;
    @Autowired
    private LocationCategoryRepository locationCategoryRepository;
    // @Autowired
    // private NearbyLocationRepository nearbyLocationRepository;
    @Autowired
    private CategoryRepository categoryrepository;
    @Autowired
    private LocationImagRepository locationImagRepository;

    //private static final String GOONG_API_KEY = "OkR5wGVtOiEJFUaa7n9znWpPP1VCNCGysbZug7qe";
    //private static final String GOONG_DISTANCE_API = "https://rsapi.goong.io/DistanceMatrix?origins=%s,%s&destinations=%s,%s&vehicle=car&api_key=" + GOONG_API_KEY;


    public List<Location> getAllLocations() {
        return locationRepository.findAll();
    }

    public Optional<Location> getLocationById(Integer id) {
        return locationRepository.findById(id);
    }

    public List<Location> getLocationsByProvince(Integer provinceId) {
        return locationRepository.findByProvinceId(provinceId);
    }


    public List<Location> getLocationsByCategory(Integer categoryId, List<Location> locationList){
        Optional<Category> categoryList = categoryrepository.findById(categoryId);

        if (categoryList.isEmpty()) {
            return new ArrayList<>();
        }

        Category category = categoryList.get();

        List<Location> result = new ArrayList<>();
        for (Location loc : locationList){
            if(loc.getCategories().contains(category)){
                result.add(loc);
            }
        }

        return result;
    }

    //cần sửa thêm(**)
    public Location getLocationByName(String locationName){
        return locationRepository.findByName(locationName);
    }
    
    //cần sửa thêm(**)

    @Transactional
    public List<Map<String, Object>> getNearbyLocations(Integer locationId) {
        Location centerLocation = locationRepository.findById(locationId).orElseThrow(() ->
        new RuntimeException("location not found"));

        double center_Lat = centerLocation.getLatitude().doubleValue();
        double center_Lng = centerLocation.getLongitude().doubleValue();

        double radiusKm = 20.0;
        double earthRadius = 6371.0;
    
        double deltaLat = Math.toDegrees(radiusKm / earthRadius);
        double deltaLng = Math.toDegrees(radiusKm / (earthRadius * Math.cos(Math.toRadians(center_Lat))));
    
        BigDecimal minLat = BigDecimal.valueOf(center_Lat - deltaLat);
        BigDecimal maxLat = BigDecimal.valueOf(center_Lat + deltaLat);
        BigDecimal minLng = BigDecimal.valueOf(center_Lng - deltaLng);
        BigDecimal maxLng = BigDecimal.valueOf(center_Lng + deltaLng);
    
        List<Location> candidates = locationRepository.findLocationsInBoundingBox(
                locationId, minLat, maxLat, minLng, maxLng
        );
    
        List<Map<String, Object>> nearby = new ArrayList<>();
        for (Location loc : candidates) {
            double distance = getDistance(center_Lat, center_Lng,
                                        loc.getLatitude().doubleValue(), loc.getLongitude().doubleValue());
    
            if (distance <= 20.0) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", loc.getId());
                map.put("name", loc.getName());
                map.put("latitude", loc.getLatitude());
                map.put("longitude", loc.getLongitude());
                map.put("images", loc.getImages());
                map.put("distance_km", Math.round(distance * 100.0) / 100.0); // Làm tròn 2 chữ số
                map.put("province", loc.getProvince());
                nearby.add(map);
            }
        }

        return nearby;
    }

    public Location saveLocation(Location location, Set<com.app.backend.model.Category> categories, List<LocationImage> images) {

        Location savedLocation = locationRepository.save(location);

        //thêm data liên quan vào location_category

        for(com.app.backend.model.Category category : categories){
            LocationCategory objadd = new LocationCategory(savedLocation, category);
            locationCategoryRepository.save(objadd);
        }

        // thêm ảnh cho location vào location_images(**cần sửa thêm**)
        if(!images.isEmpty()){
            for(LocationImage image : images){
                image.setLocation(savedLocation);
                locationImagRepository.save(image);
            }
        }

        //tìm và thêm nearby_location
        // if(savedLocation.getLongitude() == null || savedLocation.getLatitude() == null){
        //     return savedLocation;
        // }

        // List<Location> nearbyLocations = locationRepository.findByProvinceId(location.getProvince().getId());
        // for(Location loc : nearbyLocations){

        //     BigDecimal distance = getDistance(loc, savedLocation);

        //     if (!loc.getId().equals(savedLocation.getId()) &&  distance != null && distance.compareTo(BigDecimal.valueOf(20)) <= 0) {
        //         nearbyLocationRepository.save(new NearbyLocation(savedLocation, loc,distance));
        //     }

        //     try {
        //         Thread.sleep(1000); // Dừng 1 giây giữa các request để tránh quá tải
        //     } catch (InterruptedException e) {
        //         Thread.currentThread().interrupt();
        //     }
        // }

        return savedLocation;
    }

    public Location updateLocation(Integer id, Location locationDetails, List<LocationImage> images) {
        Optional<Location> optionalLocation = locationRepository.findById(id);
        if (!optionalLocation.isPresent()) {
            return null; // Không tìm thấy địa điểm, trả về null
        }

        Location existingLocation = optionalLocation.get();

        // Cập nhật thông tin địa điểm
        existingLocation.setName(locationDetails.getName());
        existingLocation.setDescription(locationDetails.getDescription());
        // existingLocation.setLatitude(locationDetails.getLatitude());
        // existingLocation.setLongitude(locationDetails.getLongitude());
        // existingLocation.setProvince(locationDetails.getProvince());

        // // Cập nhật danh mục nếu có [*ko cần thiết có thể chỉnh sửa sau*]
        // if (locationDetails.getCategories() != null) {
        //     locationCategoryRepository.deleteById(null);; // Xóa danh mục cũ
        //     for (Category category : locationDetails.getCategories()) {
        //         locationCategoryRepository.save(new LocationCategory(existingLocation, category));
        //     }
        // }

        // Cập nhật ảnh (Thêm/Sửa/Xóa)
        List<LocationImage> existingImages = locationImagRepository.findByLocation(existingLocation);
        Set<String> newImageUrls = images.stream().map(LocationImage::getImage_url).collect(Collectors.toSet());

        // Xóa ảnh không còn tồn tại trong danh sách mới
        for (LocationImage oldImage : existingImages) {
            if (!newImageUrls.contains(oldImage.getImage_url())) {
                locationImagRepository.delete(oldImage);
            }
        }

        // Thêm ảnh mới nếu chưa có
        for (LocationImage newImage : images) {
            if (existingImages.stream().noneMatch(img -> img.getImage_url().equals(newImage.getImage_url()))) {
                newImage.setLocation(existingLocation);
                locationImagRepository.save(newImage);
            }
        }

        // Lưu địa điểm đã cập nhật  
        return locationRepository.save(existingLocation);
    }


    public void deleteLocation(Integer id) {
        locationRepository.deleteById(id);
    }

    // tính khoảng cách 2 địa điểm bằng công thức haversine
    private double getDistance(double lat1, double lon1, double lat2, double lon2) {
        final int R = 6371; // Earth radius in km
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                 + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                 * Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c;
    }

    // @Transactional
    // public void updateNearbyLocations(Location location){

    //     //xóa dữ liệu cũ
    //     nearbyLocationRepository.deleteByLocationId(location.getId());
    //     nearbyLocationRepository.deleteByNearbyLocationId(location.getId());

    //     //lấy danh sách các địa điểm cùng tỉnh
    //     List<Location> locationInProvince = locationRepository.findByProvinceId(location.getId());

    //     for(Location loc : locationInProvince){
    //         if(!loc.getId().equals(location.getId())){
    //             BigDecimal distance = getDistance(loc, location);

    //             if(distance != null && distance.compareTo(BigDecimal.valueOf(20))<=0){
    //                 nearbyLocationRepository.save(new NearbyLocation(location, loc, distance));
    //             }

    //             try {
    //                 Thread.sleep(1000); // Dừng 1 giây giữa các request để tránh quá tải
    //             } catch (InterruptedException e) {
    //                 Thread.currentThread().interrupt();
    //             }
    //         }

    //     }
    // }

}
