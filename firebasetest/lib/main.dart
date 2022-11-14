import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import '/routes.dart';
import '/screens/login.dart';
import 'package:flutter/material.dart';
List<CameraDescription> cameras = [];

Future<void> main() async {
  try{
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error retrieving cameras: $e');
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.id,
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}
