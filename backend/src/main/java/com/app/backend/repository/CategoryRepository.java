package com.app.backend.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.app.backend.model.Category;



public interface CategoryRepository extends JpaRepository<Category, Integer> {
    Category findByName(String name);
    Optional<Category> findByNameIgnoringCase(String name);
}
