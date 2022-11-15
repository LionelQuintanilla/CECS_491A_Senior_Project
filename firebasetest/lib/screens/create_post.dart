import 'package:camera/camera.dart';
import 'package:firebasetest/screens/new_post_description.dart';
import 'package:firebasetest/screens/verification_screen.dart';
import 'package:firebasetest/utils/share_resources.dart';
import 'package:flutter/services.dart';
import '/components/custom_button.dart';
import '/components/custom_textfield.dart';
import '/components/snackbar.dart';
import '/core/authentication_service.dart';
import '/core/firebase_exceptions.dart';
import '/screens/login.dart';
import '/screens/home_screen.dart';
import '/utils/loader.dart';
import '/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '/screens/new_post_description.dart';


class CreatePost extends StatefulWidget{
  static const String id = 'create_post';
  const CreatePost({Key? key}) : super(key:key);

  @override
  State<CreatePost> createState() => _CreatePost();

}

class _CreatePost extends State<CreatePost>{
  File? _image;

  final _picker = ImagePicker();

  Future<String?> pickImage() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    var path = file?.path;
    postImagePath = path;
    if (file != null) {
      setState(() {
        _image = File(file.path);
      });
    }
    return file?.path;
  }

 Future<String?> camera() async{
    final file = await ImagePicker().pickImage(source: ImageSource.camera,
    maxHeight: 1800,
    maxWidth: 1800);
    var path = file?.path;
    postImagePath = path;
    if (file != null){
      setState(() {
        _image = File(file.path);
      });
    }
    return file?.path;
 }

  final _key = GlobalKey<FormState>();

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset('assets/images/backArrow.png',
                          height: 40,
                          width: 40)
                  ),
                  const Align(
                    child: Text(
                      'New',
                      style: TextStyle(
                        fontFamily: 'Cherry',
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    child: Text(
                      'Post',
                      style: TextStyle(
                        fontFamily: 'Cherry',
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          constraints: const BoxConstraints(minHeight: 200,maxHeight: 400,minWidth: 200, maxWidth: 250),
                          decoration: BoxDecoration(
                              border: Border.all(width: 10,color: Colors.black),
                              borderRadius: BorderRadius.circular(5) ,
                              boxShadow: const [BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 15,
                                  offset: Offset(1, 5)
                              )]
                          ),

                          child: Image.file(
                              File(_image!.path)//displays the image from the previous page
                          )
                      )
                  ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child:
                            ElevatedButton(
                              onPressed: () async{
                                camera();
                                },
                                style: ElevatedButton.styleFrom(
                                backgroundColor : Colors.white,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                                side: const BorderSide(color: Colors.black),
                                )
                                ),
                                child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.black,
                                size: 50,

                                ),
                                ),
                                ),
                                Spacer(),
                                Align(
                                alignment: Alignment.centerRight,
                                child:
                                OutlinedButton(
                                onPressed: () async {
                                pickImage();
                                },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    side: const BorderSide(color: Colors.black),
                                  )
                              ),
                              child: const Icon(
                                Icons.add_to_photos_outlined,
                                color: Colors.black,
                                size: 50,

                              ),
                            ),
                          ),
                        ],
                      ),

                  const SizedBox(height: 30),
                  Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 250,
                          height: 50,
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.pushNamed(context, CreatePost.id),
                            icon: const Icon(
                              Icons.upload,
                              size: 24.0,
                            ),
                            label: const Text('Upload Draft'),
                            style: OutlinedButton.styleFrom(
                              //Button size in order to take up the whole screen
                              minimumSize: const Size.fromHeight(100),
                              shape: const StadiumBorder(),
                              //colors
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              //width of the border for our button
                              side: const BorderSide(width: 5.0, color: Colors.black),
                              //centers text
                              alignment: Alignment.center,
                              textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                            ),
                          ),
                        ),
                      )
                  ),
                  const SizedBox(height: 25),
                  Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostDescription( file: FileImage(File(postImagePath))))),
                            child: const Text('Next'),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(75),
                              shape: const StadiumBorder(),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              side: const BorderSide(width: 5.0, color: Colors.black),
                              alignment: Alignment.center,
                              textStyle: const TextStyle( fontWeight: FontWeight.bold, fontSize: 40.0),
                            ),
                          ),
                        ),
                      )
                      ),
                    ],
                  ),
              ),
            ),
          ),
        ),
    );
  }
}