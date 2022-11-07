import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '/screens/create_post.dart';

class CameraScreen extends StatefulWidget{
  @override
  _CameraScreenState createState() => _CameraScreenState();

}

class _CameraScreenState extends State<CameraScreen>{
  CameraController? controller;
  bool _isCameraInitialized = false;

  void onNewCameraSelected(CameraDescription cameraDescription) async{
    final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.ultraHigh,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try{
      await cameraController.initialize();
    } on CameraException catch (e){
      print('Error initializing camera: $e');
    }

    if (mounted){
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold();
  }
}