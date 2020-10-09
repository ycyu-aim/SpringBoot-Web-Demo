package com.example.demotest.Enum;

public enum BasicSalary {
    ZEROTOFIVEK(0.00f, 4999.99f),
    FIVETOTENK(5000.00f,9999.99f),
    TENTOFIFTHKK(10000.00f,14999.99f),
    OVERFIFTH(15000.00f,99999.00f);

    private Float down;
    private Float up;
    BasicSalary(Float down,Float up) {
        this.down= down;
        this.up=up;
    }
    public  Float getDown(){
        return this.down;
    }
    public  Float getUp(){
        return this.up;
    }


}
