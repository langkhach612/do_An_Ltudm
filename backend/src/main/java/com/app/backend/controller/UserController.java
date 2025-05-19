package com.app.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.app.backend.model.AuthRespone;
import com.app.backend.model.Request;
import com.app.backend.model.User;
import com.app.backend.repository.UserRepository;
import com.app.backend.security.JwtUtil;
import com.app.backend.service.UserService;

@RestController
@RequestMapping("/auth")
public class UserController {
    @Autowired
    private AuthenticationManager  authenticationManager;

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/login")
    public AuthRespone login(@RequestBody Request request) {
        // Xác thực thông tin người dùng
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getUsername(),
                        request.getPassword()
                )
        );

        // Nếu đúng thì sinh token
        UserDetails userDetails = userService.loadUserByUsername(request.getUsername());
        String token = jwtUtil.generateToken(userDetails);

        AuthRespone tok = new AuthRespone(token);

        return tok;
    }

    @PostMapping("/register")
    public ResponseEntity<String> postMethodName(@RequestBody Request request) {
        if (userRepository.findByUsername(request.getUsername()).isPresent() || 
            (userRepository.findByEmail(request.getEmail()).isPresent() 
            && userRepository.findByEmail(request.getEmail()) != null)) {
            return ResponseEntity.badRequest().body("Username or email already exists");
        }
    
        User newUser = new User();
        newUser.setUsername(request.getUsername());
        newUser.setPassword(passwordEncoder.encode(request.getPassword()));
        newUser.setEmail(request.getEmail());
    
        userRepository.save(newUser);
        return ResponseEntity.ok("User registered successfully");
    }
}
