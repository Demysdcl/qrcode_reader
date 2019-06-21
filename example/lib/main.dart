
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'QRCode Reader Demo',
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final Map<String, dynamic> pluginParameters = {
  };

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<String> _barcodeString;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('QRCode Reader IX'),
      ),
      body: new Center(
          child: new Column(
            children: <Widget>[
              buildFutureQrImage(),
              buildFutureText(),
              buildFutureFlatButton(),
            ],
          )
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          readQrCode();
        },

        tooltip: 'QRCode Reader',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  void readQrCode() {
    setState(() {
      _barcodeString = new QRCodeReader()
          .setAutoFocusIntervalInMs(200)
          .setForceAutoFocus(true)
          .setTorchEnabled(true)
          .setHandlePermissions(true)
          .setExecuteAfterPermissionGranted(true)
          .setFrontCamera(false)
          .scan();
    });
  }

  FutureBuilder<String> buildFutureText() {
    return new FutureBuilder<String>(
              future: _barcodeString,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return new Text(snapshot.data != null ? snapshot.data : '');
            });
  }

  FutureBuilder<String> buildFutureQrImage() {
    return new FutureBuilder<String>(
              future: _barcodeString,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return new Padding(
                    padding: EdgeInsets.all(40),
                    child: new QrImage(
                      data: snapshot.data != null ? snapshot.data : '',
                      size: 200,
                    )
                );
            });
  }

  FutureBuilder<String> buildFutureFlatButton() {
    return new FutureBuilder<String>(
        future: _barcodeString,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return snapshot.data != null && snapshot.data.contains("http")  ? new FlatButton(
            child: new Text("Abrir URL"),
            color: Colors.blue,
            onPressed: (() => {
              _launchURL(snapshot.data)
            }),
          ) : new Text("");
        });
  }

  _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      }
  }
}
