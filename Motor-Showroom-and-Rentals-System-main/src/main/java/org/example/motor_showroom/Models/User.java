package org.example.motor_showroom.Models;

public class User {
    private int userId;
    private String username;
    private String email;
    private String password;
    private String address;
    private String role;

    // Constructors
    public User() {}

    public User(String username, String email, String password, String address, String role) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.address = address;
        this.role = role;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}