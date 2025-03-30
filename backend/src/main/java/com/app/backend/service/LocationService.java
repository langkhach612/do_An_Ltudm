package com.app.backend.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.app.backend.model.Category;
import com.app.backend.model.Location;
import com.app.backend.model.LocationCategory;
import com.app.backend.model.LocationImage;
import com.app.backend.model.NearbyLocation;
import com.app.backend.repository.*;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.transaction.Transactional;

@Service
public class LocationService {

    @Autowired
    private LocationRepository locationRepository;
    @Autowired
    private LocationCategoryRepository locationCategoryRepository;
    @Autowired
    private NearbyLocationRepository nearbyLocationRepository;
    @Autowired
    private CategoryRepository categoryrepository;
    @Autowired
    private LocationImagRepository locationImagRepository;

    private static final String GOONG_API_KEY = "OkR5wGVtOiEJFUaa7n9znWpPP1VCNCGysbZug7qe";
    private static final String GOONG_DISTANCE_API = "https://rsapi.goong.io/DistanceMatrix?origins=%s,%s&destinations=%s,%s&vehicle=car&api_key=" + GOONG_API_KEY;


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
        
        Location location = locationRepository.findById(locationId)
                .orElseThrow(() -> new RuntimeException("Location not found"));

        List<NearbyLocation> nearbyLocations = nearbyLocationRepository.findNearbyLocations(locationId);

        // Kiểm tra nếu dữ liệu đã cũ (> 2 tuần)
        boolean shouldUpdate = nearbyLocations.stream()
                .anyMatch(nl -> nl.getUpdated_at().before(Timestamp.valueOf(LocalDateTime.now().minusWeeks(2))));

        if (shouldUpdate) {
            updateNearbyLocations(location);
            nearbyLocations = nearbyLocationRepository.findNearbyLocations(locationId);
        }

        // Format kết quả trả về
        List<Map<String, Object>> response = new ArrayList<>();
        for (NearbyLocation nl : nearbyLocations) {
            Map<String, Object> map = new HashMap<>();

            if(nl.getLocation().getId() == locationId){
                map.put("id", nl.getNearbyLocation().getId());
                map.put("name", nl.getNearbyLocation().getName());
                map.put("latitude", nl.getNearbyLocation().getLatitude());
                map.put("longitude", nl.getNearbyLocation().getLongitude());
                map.put("img", nl.getNearbyLocation().getImages());          
            }
            else{
                map.put("id", nl.getLocation().getId());
                map.put("name", nl.getLocation().getName());
                map.put("latitude", nl.getLocation().getLatitude());
                map.put("longitude", nl.getLocation().getLongitude());
                map.put("img", nl.getLocation().getImages());
            }

            map.put("distance_km", nl.getDistance_km());

            response.add(map);
        }
        return response;
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
        if(savedLocation.getLongitude() == null || savedLocation.getLatitude() == null){
            return savedLocation;
        }

        List<Location> nearbyLocations = locationRepository.findByProvinceId(location.getProvince().getId());
        for(Location loc : nearbyLocations){

            BigDecimal distance = getDistance(loc, savedLocation);

            if (!loc.getId().equals(savedLocation.getId()) &&  distance != null && distance.compareTo(BigDecimal.valueOf(20)) <= 0) {
                nearbyLocationRepository.save(new NearbyLocation(savedLocation, loc,distance));
            }

            try {
                Thread.sleep(1000); // Dừng 1 giây giữa các request để tránh quá tải
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }

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
        existingLocation.setLatitude(locationDetails.getLatitude());
        existingLocation.setLongitude(locationDetails.getLongitude());
        existingLocation.setProvince(locationDetails.getProvince());

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

    // tìm các địa điểm gần nhau trong cùng 1 Province(>=20km) [**cần check lại sau**]
    private BigDecimal getDistance(Location loc1, Location loc2) {
        try {
            String url = String.format(GOONG_DISTANCE_API, loc1.getLatitude(), loc1.getLongitude(), loc2.getLatitude(), loc2.getLongitude());
            RestTemplate restTemplate = new RestTemplate();
            String response = restTemplate.getForObject(url, String.class);
            
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonResponse = objectMapper.readTree(response);
            
            if (jsonResponse.has("rows")) {
                JsonNode rows = jsonResponse.get("rows");
                if (rows.isArray() && rows.size() > 0) {
                    JsonNode elements = rows.get(0).get("elements");
                    if (elements.isArray() && elements.size() > 0) {
                        JsonNode distanceObj = elements.get(0).get("distance");
                        if (distanceObj.has("value")) {
                            double distanceInKm = distanceObj.get("value").asDouble() / 1000; // Chuyển đổi từ mét sang km
                            return BigDecimal.valueOf(distanceInKm).setScale(2, RoundingMode.HALF_UP);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    @Transactional
    public void updateNearbyLocations(Location location){

        //xóa dữ liệu cũ
        nearbyLocationRepository.deleteByLocationId(location.getId());
        nearbyLocationRepository.deleteByNearbyLocationId(location.getId());

        //lấy danh sách các địa điểm cùng tỉnh
        List<Location> locationInProvince = locationRepository.findByProvinceId(location.getId());

        for(Location loc : locationInProvince){
            if(!loc.getId().equals(location.getId())){
                BigDecimal distance = getDistance(loc, location);

                if(distance != null && distance.compareTo(BigDecimal.valueOf(20))<=0){
                    nearbyLocationRepository.save(new NearbyLocation(location, loc, distance));
                }

                try {
                    Thread.sleep(1000); // Dừng 1 giây giữa các request để tránh quá tải
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
            }

        }
    }

}
