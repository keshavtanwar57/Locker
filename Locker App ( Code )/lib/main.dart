import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'passwordmanager.dart';
import 'Home.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'userbiometrics.dart';

bool BiometricEnable = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String>("PasswordVault");
  await Hive.openBox<String>("UserData");
  Box<String> UserBox = Hive.box<String>("UserData");
  UserBox = Hive.box<String>("UserData");
  try {
    String key = UserBox.get('BiometricEnable')!;
    BiometricEnable = key == 'true' ? true : false;
  } catch (e) {
    UserBox.put('BiometricEnable', 'false');
    BiometricEnable = false;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: BiometricEnable == true ? Verify() : Home(),
    );
  }
}
