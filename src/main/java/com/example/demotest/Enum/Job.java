package com.example.demotest.Enum;


public enum Job {
    DEVELOPMENTENGINEER("开发工程师"),
    IMPLEMENTATIONENGINEER("实施工程师"),
    DBAENGINEER("DBA"),
    PRODUCTMANAGER("产品经理"),
    PROJECTMANAGER("项目经理"),
    HR("HR");


    private String code;
     Job(String code ) {
        this.code= code;
    }
    public  String getCode(){
         return this.code;
    }

}
