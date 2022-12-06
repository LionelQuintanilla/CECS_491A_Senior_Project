import 'package:camera/camera.dart';
import 'package:firebasetest/screens/new_post_description.dart';
import 'package:firebasetest/screens/verification_screen.dart';
import 'package:firebasetest/utils/db_resources.dart';
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
import 'package:cloud_firestore/cloud_firestore.dart';
import '/utils/share_resources.dart';

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
<<<<<<< Updated upstream
                      alignment: Alignment.center,
                      child: Container(
                          constraints: const BoxConstraints(minHeight: 100,maxHeight: 300,minWidth: 200, maxWidth: 350),
                          decoration: BoxDecoration(
                              border: Border.all(width: 10,color: Colors.black),
                              borderRadius: BorderRadius.circular(5) ,
                              boxShadow: const [BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 15,
                                  offset: Offset(1, 5)
                              )]
                          ),

                          child: _image == null ? Image.asset('assets/images/No_Image_Available.jpg') : Image.file(
                              File(_image!.path) //displays the image from the previous page
                          )
                      )
=======
                        child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 200),
                            child: (
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: 300,
                                  width: 300,
                                  child: CircleAvatar(
                                    backgroundImage: _image == null
                                    ? null
                                    : FileImage(File(postImagePath))
                                  )
                                ),
                              )
                            ),
                        ),
                            alignment: Alignment.center
>>>>>>> Stashed changes
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 40),
                      FloatingActionButton(
                          shape: const StadiumBorder(
                              side: BorderSide(
                                color: Colors.black,width: 5,
                              )
                          ),
                          backgroundColor: Colors.white,

                          child:  const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                            size: 40,
                          ),
                          onPressed:() async{
                            camera();
                          }

                      ),
                      const Spacer(),
                      FloatingActionButton(
                          shape: const StadiumBorder(
                              side: BorderSide(
                                color: Colors.black,width: 5,
                              )
                          ),
                          backgroundColor: Colors.white,
                          child: const Icon(
                            Icons.photo_library_rounded,
                            color: Colors.black,
                            size: 40,
                          ),
                          onPressed:() async{
                            pickImage();
                          }

                      ),
                      const SizedBox(width: 40),
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
                            onPressed: () async {
                              bool foundSavedPost = await getSavedPost();
                              if (foundSavedPost == true) {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostDescription( file: FileImage(File(postImagePath)))));
                              }
                              else {
                                CustomSnackBar.showErrorSnackBar(
                                  context, message: ("No saved post found."),
                                );
                              }
                            },
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

Future<bool> getSavedPost() async {

  bool result = false;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference posts = firestore.collection('posts');

  await posts.where("userid", isEqualTo: userID).get().then(
          (res) {
        if (res.size == 1) {
          print("userid: " + userID);
          print("Got saved post");
          var savedPost = res.docs[0];
          description = savedPost.get("description");
          hashtags = savedPost.get("hashtags");
          tags = savedPost.get("tags");
          postImagePath = savedPost.get("postImagePath");
          print("description: " + description);
          descriptionController.text = description;
          print("hashtags: " + hashtags);
          hashtagController.text = hashtags;
          print("tags: " + tags);
          taggedPeopleController.text = tags;
          result = true;
        }
        else {
          print("Couldn't get saved post");
        }
      },
      onError: (e) {
        print("Couldn't get saved post");
        result = false;
      }
  );
  return result;
}