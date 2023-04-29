import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:battery_plus/battery_plus.dart';

class DeviceInfoItem {
  const DeviceInfoItem(this.label, this.value);

  final String label;
  final String? value;

  @override
  String toString() => '$label,$value';
}

class DeviceInfo {
  const DeviceInfo._(this.name, this.items);

  factory DeviceInfo.android(AndroidDeviceInfo androidInfo) {
    final List<DeviceInfoItem> items = <DeviceInfoItem>[
      DeviceInfoItem('Android version', androidInfo.version.release.toString()),
      DeviceInfoItem('BaseOS', androidInfo.version.baseOS.toString()),
      DeviceInfoItem('SDK', androidInfo.version.sdkInt.toString()),
      DeviceInfoItem('SecurityPatch', androidInfo.version.securityPatch.toString()),
      DeviceInfoItem('Base OS', androidInfo.version.baseOS),
      DeviceInfoItem('Hardware', androidInfo.hardware),
      DeviceInfoItem('Device', androidInfo.device),
      DeviceInfoItem('Manufacturer', androidInfo.manufacturer),
      DeviceInfoItem('Bootloader', androidInfo.bootloader),
      DeviceInfoItem('Board', androidInfo.board),
      DeviceInfoItem('Features', androidInfo.systemFeatures.join(', ')),
    ];
    return DeviceInfo._(androidInfo.device, items);
  }

  factory DeviceInfo.iOS(IosDeviceInfo iOSInfo) {
    final List<DeviceInfoItem> items = <DeviceInfoItem>[
      DeviceInfoItem('name', iOSInfo.name.toString()),
      DeviceInfoItem('systemName', iOSInfo.systemName.toString()),
      DeviceInfoItem('systemVersion', iOSInfo.systemVersion),
      DeviceInfoItem('model', iOSInfo.model),
      DeviceInfoItem('localizedModel', iOSInfo.localizedModel),
      DeviceInfoItem('identifierForVendor', iOSInfo.identifierForVendor),
      DeviceInfoItem('isPhysicalDevice', iOSInfo.isPhysicalDevice.toString()),
      DeviceInfoItem('utsname - sysname', iOSInfo.utsname.sysname),
      DeviceInfoItem('utsname - nodename', iOSInfo.utsname.nodename),
      DeviceInfoItem('utsname - release', iOSInfo.utsname.release),
      DeviceInfoItem('utsname - version', iOSInfo.utsname.version),
      DeviceInfoItem('utsname - machine', iOSInfo.utsname.machine),
    ];
    return DeviceInfo._(iOSInfo.name, items);
  }

  factory DeviceInfo.windows(WindowsDeviceInfo windowsDeviceInfo) {
    final List<DeviceInfoItem> items = <DeviceInfoItem>[
      DeviceInfoItem('Computer', windowsDeviceInfo.computerName),
      DeviceInfoItem('Cores', windowsDeviceInfo.numberOfCores.toString()),
      DeviceInfoItem('Memory (mb)', windowsDeviceInfo.systemMemoryInMegabytes.toString()),
    ];
    return DeviceInfo._(windowsDeviceInfo.computerName, items);
  }

  final List<DeviceInfoItem> items;
  final String? name;

  @override
  String toString() {
    return 'label,value\n' + items.join('\n');
  }
}

enum BatteryState { full, charging, discharging, unknown }

class BatteryInfo {
  BatteryInfo({required this.level, required this.state});

  final int level;
  final BatteryState state;
}

class DeviceInfoService {
  final _device = DeviceInfoPlugin();
  final _battery = Battery();

  Future<DeviceInfo?> retrieve() async {
    DeviceInfo? result;
    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await _device.androidInfo;
        result = DeviceInfo.android(androidInfo);
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await _device.iosInfo;
        result = DeviceInfo.iOS(iosInfo);
      } else if (Platform.isWindows) {
        final WindowsDeviceInfo windowsDeviceInfo = await _device.windowsInfo;
        result = DeviceInfo.windows(windowsDeviceInfo);
      }
    } catch (e) {
      // TODO(romain):
    }
    return result;
  }

  Future<BatteryInfo> battery() async {
    final state = await _battery.batteryState;
    final level = await _battery.batteryLevel;
    return BatteryInfo(level: level, state: BatteryState.values.byName(state.name));
  }
}
