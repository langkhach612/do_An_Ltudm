package com.app.backend.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.app.backend.model.User;
//import java.util.List;


public interface UserRepository extends JpaRepository<User, Integer>{
    Optional<User> findByUsername(String username);
    List<User>  findByEmail(String email);
}
