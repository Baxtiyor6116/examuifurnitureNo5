import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mebeluiexam/UI/main_page.dart';
import 'package:mebeluiexam/UI/signUp.dart';
import 'package:mebeluiexam/main.dart';
import 'package:mebeluiexam/sms_verify/sms_verify_code.dart';

FirebaseAuth _authUser = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  static File? image;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  var send = Firebase.initializeApp();
  String? phone;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var a;
  String? _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Luxury furniture app",
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),

                Text("Sign Up with Phone Number"),

                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    _imgFromGallery();
                  },
                  child: LoginPage.image != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(LoginPage.image!),
                          radius: 40.0,
                          backgroundColor: Colors.indigo.shade400,
                        )
                      : CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.orange,
                          child: Icon(
                            CupertinoIcons.camera,
                            color: Colors.grey.shade100,
                            size: 32.0,
                          ),
                        ),
                ),

                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        hintText: "Enter your name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onSaved: (es) {
                      email = es;
                    },
                    validator: (text) {
                      if (text!.length < 6) {
                        return "Kamida 6 ta belgi kerak";
                      }
                    },
                  ),
                ),

                // Email
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onSaved: (e) {
                      print("Telefon Uzunligi: ${e!.length}");
                      phone = e;
                    },
                    initialValue: "+998",
                    maxLength: 13,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Bo'sh Qolishi Mumkin Emas !";
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  child: Text("Sign In with phone number"),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await _authUser.verifyPhoneNumber(
                          phoneNumber: phone!,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed:
                              (FirebaseAuthException credential) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text(
                                    "Smsni Tekshirib Qaytadan Urinib Ko'ring !"),
                              ),
                            );
                          },
                          codeSent:
                              (String verificationId, int? resendToken) async {
                            await _authUser.currentUser!
                                .updateDisplayName(email.toString());
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VerifySmsCode(phone, verificationId)));
                          },
                          codeAutoRetrievalTimeout: (String text) {
                            print("TEXT: $text");
                          });
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                // Email

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                        child: Text("with Google"),
                        onPressed: () {
                          if (_googleSignIn() != null) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return HomePage();
                            }));
                          }
                        }),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: Text("Skip"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MainPage(0)));
                      },
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.greenAccent),
                  child: Text("Sign Up"),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser!.authentication;

    var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      LoginPage.image = File(image!.path);
      a = LoginPage.image;
    });
  }

  void showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Photo Library'),
                  onTap: () {
                    _imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
