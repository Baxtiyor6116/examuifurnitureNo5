import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:mebeluiexam/UI/login_page.dart';

FirebaseAuth _authUser = FirebaseAuth.instance;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static File? image;
  var a;
  bool _onOff = false;
  bool _onOff2 = true;
  final picker = ImagePicker();

  Future getImage() async {
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 70.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.alegreya(
            textStyle: TextStyle(
              color: Color(0xFF0F1826),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.redAccent,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierColor: Colors.grey.shade200,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Sizda hozircha hech qanday xabarlar yo'q"),
                        content: SingleChildScrollView(
                          child: Text(
                              "Ushbu oynada sizga jo'natilgan xabarnomalar bilan tanishasiz."),
                        ),
                        actions: [
                          Container(
                            height: 25.0,
                            width: 100,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel"),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Row(
                children: [
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
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Color(0xFF0F1826).withOpacity(0.05),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          "Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F1826),
                          ),
                        ),
                        subtitle: Text(
                          "${_authUser.currentUser!.displayName}",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.amber.withOpacity(0.6)),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Color(0xFF0F1826),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Color(0xFF0F1826).withOpacity(0.05),
                ),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(
                    "${_authUser.currentUser!.displayName}",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F1826),
                    ),
                  ),
                  subtitle: Text(
                    "${_authUser.currentUser!.phoneNumber}",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F1826).withOpacity(0.6)),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Color(0xFF0F1826),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Color(0xFF0F1826).withOpacity(0.05),
                ),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    CupertinoIcons.sun_max_fill,
                    color: Color(0xFF0F1826),
                  ),
                  title: Text(
                    "Theme",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F1826),
                    ),
                  ),
                  trailing: CupertinoSwitch(
                    trackColor: Colors.white,
                    activeColor: Color(0xFF0F1826),
                    value: _onOff,
                    onChanged: (e) {
                      setState(() {
                        _onOff = e;
                      });
                    },
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Color(0xFF0F1826).withOpacity(0.05),
                ),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: Color(0xFF0F1826),
                  ),
                  title: Text(
                    "Notification",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F1826),
                    ),
                  ),
                  trailing: CupertinoSwitch(
                    trackColor: Colors.white,
                    activeColor: Color(0xFF0F1826),
                    value: _onOff2,
                    onChanged: (e) {
                      setState(() {
                        _onOff2 = e;
                      });
                    },
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Color(0xFF0F1826).withOpacity(0.05),
                ),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.support_agent,
                  ),
                  title: Text(
                    "Support",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F1826),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.send_to_mobile,
                      color: Color(0xFF0F1826),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _imgFromGallery() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      LoginPage.image = File(image!.path);
      a = LoginPage.image;
    });
  }
}
