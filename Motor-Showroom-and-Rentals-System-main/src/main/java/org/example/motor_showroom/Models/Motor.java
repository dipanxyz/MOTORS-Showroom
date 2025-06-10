package org.example.motor_showroom.Models;

public class Motor {
    private int motorId;
    private String name;
    private String type;
    private double power;
    private double price;
    private String description;
    private String imagePath;
    private boolean availability;

    // Constructors
    public Motor() {}

    public Motor(String name, String type, double power, double price, String description, String imagePath, boolean availability) {
        this.name = name;
        this.type = type;
        this.power = power;
        this.price = price;
        this.description = description;
        this.imagePath = imagePath;
        this.availability = availability;
    }

    // Getters and Setters
    public int getMotorId() { return motorId; }
    public void setMotorId(int motorId) { this.motorId = motorId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public double getPower() { return power; }
    public void setPower(double power) { this.power = power; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
    public boolean isAvailability() { return availability; }
    public void setAvailability(boolean availability) { this.availability = availability; }
}