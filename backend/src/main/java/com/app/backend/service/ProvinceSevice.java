package com.app.backend.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.backend.model.Province;
import com.app.backend.repository.ProvinceRepository;

@Service
public class ProvinceSevice {

    @Autowired
    private ProvinceRepository provinceRepository;

    public List<Province> getAllProvinces(){
        return provinceRepository.findAll();
    }

    public Optional<Province> getProvinceById(Integer id){
        return provinceRepository.findById(id);
    }

    public Province saveProvince(Province province){
        return provinceRepository.save(province);
    }

    public void deleteProvince(Integer id){
        provinceRepository.deleteById(id);
    }
}
