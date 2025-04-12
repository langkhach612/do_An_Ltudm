package com.app.backend.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.app.backend.model.Category;
import com.app.backend.service.CategoryService;

import java.util.List;
//import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
//import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
@RequestMapping("/categories")
public class CategoryController {

    @Autowired
    CategoryService categoryService;

    @GetMapping("")
    public List<Category> getALLCategories () {
        return categoryService.getAllCategories();
    }
    
    @GetMapping("/{id}")
    public Optional<Category> getCategoryById(@PathVariable Integer id) {
        return categoryService.getCategoryById(id);
    }

    @PostMapping("admin/add")
    public ResponseEntity<?> addCategory(@RequestBody Category category) {
        if (categoryService.existsByName(category.getName())) {
            return ResponseEntity
                    .status(HttpStatus.CONFLICT)
                    .body("Category with name '" + category.getName() + "' already exists.");
        }
    
        Category savedCategory = categoryService.saveCategory(category);
        return new ResponseEntity<>(savedCategory, HttpStatus.CREATED);
    }
    

    @DeleteMapping("admin/delete/{id}")
    public ResponseEntity<Void> deleteCategory(@PathVariable Integer id){
        categoryService.deleteCategory(id);
        return ResponseEntity.noContent().build();
    }
    
}
