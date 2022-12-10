import 'package:flutter/material.dart';
import '/screens/facebook_add_2.dart';
import '/screens/add_accounts.dart';

class FacebookAdd extends StatefulWidget{
  static const String id = 'facebook_add';
  const FacebookAdd({Key? key}) : super(key:key);

  @override
  State<FacebookAdd> createState() => _FacebookAdd();

}

class _FacebookAdd extends State<FacebookAdd>{
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  // final _postTextController = TextEditingController();

  // String? _accessToken;
  // String? _refreshToken;

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

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
                  left: 16.0,right: 16.0, top: 50.0, bottom: 25.0),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        // Sends the user back to the last screen they visited
                        onTap: () => Navigator.pushNamed(context, AddAccounts.id),
                        child: Image.asset('assets/images/backArrow.png',
                            height: 40,
                            width: 40)
                    ),
                    const Align(
                      child:
                      Text(
                        'Add Facebook',
                        style: TextStyle(
                          fontFamily: 'Cherry',
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Align(
                      child:
                      Text(
                        'Account',
                        style: TextStyle(
                          fontFamily: 'Cherry',
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Align(
                      child:
                      Text(
                        "Clicking “Add” will take you to the sign-in page of the selected account. When you’re finished, the account will be automatically added.",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 35),
                    OutlinedButton.icon(
                      /* If this button is pressed, the user is sent to the second page
                      in the Facebook account process */
                      onPressed: () async {
                        Navigator.pushNamed(context, FacebookAdd2.id);
                      },
                      icon: const Icon(
                        Icons.people,
                        size: 50.0,
                      ),
                      label: const Text('Facebook'),
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
                        textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 45.0),
                      ),
                    ),
                    const SizedBox(height:50),
                    GestureDetector(
                        // Sends the user back to the last screen they visited
                        onTap: () => Navigator.pushNamed(context, AddAccounts.id),
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            textScaleFactor: .9,
                            text: const TextSpan(
                                text: "Cancel",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                  fontSize: 30,
                                )
                            ),
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}