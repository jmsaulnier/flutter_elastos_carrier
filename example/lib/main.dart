import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_elastos_carrier/flutter_elastos_carrier.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _carrierVersion = 'Unknown';
  String _nodeID = 'Unknown';

  @override
  void initState() {
    super.initState();
    initCarrier();
  }

  Future<void> initCarrier() async {
    String carrierVersion;
    String nodeID;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await FlutterElastosCarrier.start();
      // carrierVersion = 'Elastos Carrier started!';
    } on PlatformException {
      // carrierVersion = 'Failed to starts Elastos Carrier.';
    }

    carrierVersion = await FlutterElastosCarrier.version;
    nodeID = await FlutterElastosCarrier.nodeId;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _carrierVersion = carrierVersion;
      _nodeID = nodeID;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_carrierVersion\n - nodeID:  $_nodeID\n'),
        ),
      ),
    );
  }
}
