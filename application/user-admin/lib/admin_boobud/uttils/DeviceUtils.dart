import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:medicare/admin_boobud/dio/DeviceInfoModel/DeviceInfo.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../dio/authModels/LoginPayloadModel.dart';

class DeviceUtils {
  static Future<DeviceInfo> getDeviceInfo() async {
    String? deviceId = "unknown_device_id";
    String deviceType = "unknown";
    String os = "unknown";
    String deviceName = "unknown";
    String appVersion = "unknown";
    String countryName = "unknown";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (UniversalPlatform.isWeb) {
      // Handle Web
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;

      deviceId = webBrowserInfo.appCodeName;
      deviceType = "desktop";
      os = webBrowserInfo.browserName.name;
      deviceName = "Web Browser";
    } else {
      // Handle Mobile (Android/iOS)
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      appVersion = packageInfo.version;

      if (UniversalPlatform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceType = "mobile";
        deviceId = androidInfo.serialNumber;
        os = "Android ${androidInfo.version.release}";
        deviceName = androidInfo.model;
      } else if (UniversalPlatform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceType = "mobile";
        deviceId = iosInfo.model;
        os = "iOS ${iosInfo.systemVersion}";
        deviceName = iosInfo.utsname.machine;
      }

      // Get country info (only for mobile)
      Position? position = await _getLocation();
      if (position != null) {
        List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          countryName = placemarks.first.country ?? "Unknown";
        }
      }
    }
    return DeviceInfo(deviceType: deviceType,appVersion: appVersion,countryName: countryName,deviceId: deviceId,deviceName: deviceName,os: os);
  }

  static Future<Position?> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return null;
    }

    return await Geolocator.getCurrentPosition();
  }
}
