# QRCode Reader and URL Launcher plugins for Flutter

A Flutter plugin for reading QR Codes with the camera.

### Read Qrcode

``` dart
import 'package:qrcode_reader/qrcode_reader.dart';
```

``` dart
Future<String> futureString = new QRCodeReader()
               .setAutoFocusIntervalInMs(200) // default 5000
               .setForceAutoFocus(true) // default false
               .setTorchEnabled(true) // default false
               .setHandlePermissions(true) // default true
               .setExecuteAfterPermissionGranted(true) // default true
               .setFrontCamera(false) // default false
               .scan();
```

These options are Android only (with the exception of setFrontCamera(bool)), this is the simplest way of plugin usage:
``` dart
Future<String> futureString = new QRCodeReader().scan();
```

### Open URL

``` dart
import 'package:url_launcher/url_launcher.dart';
```

``` dart
_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}
```