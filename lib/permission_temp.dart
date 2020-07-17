import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler{
  
  Permission _permission;
  
  PermissionHandler(this._permission);
  
  Future<PermissionStatus> getStatus() async{
    
    final status = (await _permission.status).toString();
    print(status + " Ye hai asli");
    return null;
  }
  
  Future<void> requestPermission() async{
  
    await _permission.request();
  }
}