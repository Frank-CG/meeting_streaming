import 'package:flutter/material.dart';

enum DeviceType { SmartPhone, Tablets, }
enum RouteName { Meeting, Notification, }

class AppConfig {
  static AppConfig instance = new AppConfig();  
  double _screenWidth;
  double _screenHeight;
  DeviceType _deviceType;
  Orientation _orientation;



  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _deviceType = mediaQuery.size.shortestSide < 600 ? DeviceType.SmartPhone : DeviceType.Tablets;
    _orientation = mediaQuery.orientation;
  }

  static get meetingPage => RouteName.Meeting;
  static get notificationPage => RouteName.Notification;

  static get defaultFontFamily => "Nunito Sans";

  double get screenWidth => this._screenWidth;
  double get screenHeight => this._screenHeight;
  double get blockWidth => this._screenWidth / 100;
  double get blockHeight => this._screenHeight / 100;

  DeviceType get deviceType => this._deviceType;
  Orientation get orientation => this._orientation;
}