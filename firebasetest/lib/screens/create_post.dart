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

  /* Creates a File object to hold the image the user chooses. This file will
  be used to display a preview of the image */
  File? _image;

  /* Creates an instance of the ImagePicker widget that will be used to pick
  an image to post */
  final _picker = ImagePicker();

  /* An asynchronous function that allows the user to pick an image to post from
  their gallery and returns the filepath of the image */
  Future<String?> pickImage() async {
    /* The ImagePicker widget opens the image gallery on the user's device
    and allows them to choose an image. The ImagePicker then returns the image
    and saves it as a file */
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    // Gets the file path of the image
    var path = file?.path;
    // Saves the file path for the sharing API
    postImagePath = path;
    // Updates the image preview file with the user's chosen image
    if (file != null) {
      setState(() {
        _image = File(file.path);
      });
    }

    // Returns the file path of the chosen image
    return file?.path;
  }

  /* An asynchronous function that allows the user to take a picture using their
   camera to post and returns the file path of the image */
 Future<String?> camera() async{
   /* The ImagePicker widget opens the device's camera and allows them to take
   a picture. The ImagePicker then returns the picture and saves it as a file */
    final file = await ImagePicker().pickImage(source: ImageSource.camera,
    maxHeight: 1800,
    maxWidth: 1800);
    // Gets the file path of the image
    var path = file?.path;
    // Saves the file path for the sharing API
    postImagePath = path;
    // Updates the image preview file with the user's chosen image
    if (file != null){
      setState(() {
        _image = File(file.path);
      });
    }
    // Returns the file path of the picture
    return file?.path;
 }

  final _key = GlobalKey<FormState>();

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Gets the size of the current device's screen
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
                    // Returns the user to the last screen they visited
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
                          /* The preview of the image the user chooses. If the preview file has not been assigned
                          yet, it displays a default image. Otherwise, it displays the image in the preview file. */
                          child: _image == null ? Image.asset('assets/images/No_Image_Available.jpg') : Image.file(
                              File(_image!.path) //displays the image from the previous page
                          )
                      )
                  ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child:
                            ElevatedButton(
                              /* If this button is pressed, it launches the option
                              to choose an image using the device's camera */
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
                                  /* If this button is pressed, it launches the
                                  option to chose an image from the device gallery */
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
                            /* Pressing this button launches the option to import
                            a saved post */
                            onPressed: () async {
                              /* Uses the getSavedPost() method import a saved post,
                              from the user's profile, if it exists */
                              bool foundSavedPost = await getSavedPost();
                              /* If there is a saved post, the user is redirected to
                              the post details with the post details and image
                              preloaded
                               */
                              if (foundSavedPost == true) {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostDescription( file: FileImage(File(postImagePath)))));
                              }
                              else {
                                /* If there is no saved post, an error message is returned */
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
                            /* If this button is pressed, the user is directed to the
                            post details page with only the image they chose */
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

/* Checks if the user has a saved post in their account. If there is, the post is
retrieved and the details are loaded into app */
Future<bool> getSavedPost() async {

  // Returns a boolean value for if a post is detected
  bool result = false;

  /* Connects to the Firestore Cloud database. Firestore is a NoSQL database that
  stores files in groupings called "collections" */
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Accesses the collection used to store posts
  CollectionReference posts = firestore.collection('posts');

  // Searches the database for a post marked with the user's profile ID
  await posts.where("userid", isEqualTo: userID).get().then(
      (res) {
        if (res.size == 1) {
          /* If a post is found with the user's profile ID, the post is queried
          and the contents of the post are loaded into the app */
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
        /* If a post with the user's profile ID couldn't or there was an error
        accessing the database, a failure message is returned. */
        print("Couldn't get saved post");
            result = false;
      }
  );
  return result;
}