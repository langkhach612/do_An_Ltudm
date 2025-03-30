package com.app.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.app.backend.model.Province;

public interface ProvinceRepository extends JpaRepository<Province, Integer> {
}
