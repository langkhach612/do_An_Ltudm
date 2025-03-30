// package com.app.backend.model;

// import jakarta.persistence.Column;
// import jakarta.persistence.Entity;
// import jakarta.persistence.GeneratedValue;
// import jakarta.persistence.GenerationType;
// import jakarta.persistence.Id;
// import jakarta.persistence.JoinColumn;
// import jakarta.persistence.Lob;
// import jakarta.persistence.ManyToOne;
// import jakarta.persistence.Table;
// import lombok.Getter;
// import lombok.Setter;

// @Getter
// @Setter
// @Entity
// @Table(name = "admin_logs")
// public class AdminLog {
//     @Id
//     @GeneratedValue(strategy = GenerationType.IDENTITY)
//     private Integer id;
    
//     @ManyToOne
//     @JoinColumn(name = "admin_id", nullable = false)
//     private User admin;

//     @Lob
//     @Column(columnDefinition = "TEXT",nullable = false)
//     private String action;
// }
