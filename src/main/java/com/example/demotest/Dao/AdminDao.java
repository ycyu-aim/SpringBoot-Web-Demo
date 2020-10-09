package com.example.demotest.Dao;

import com.example.demotest.Entity.Admin;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AdminDao extends JpaRepository<Admin, Long> {
    Optional<Admin> findByUsername(String username);
}
