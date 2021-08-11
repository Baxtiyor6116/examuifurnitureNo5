import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mebeluiexam/UI/login_page.dart';

FirebaseAuth _authUser = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _formKey1 = GlobalKey<FormFieldState>();
  var _formKey2 = GlobalKey<FormFieldState>();
  var _formKey3 = GlobalKey<FormFieldState>();
  String? parolUshla;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Let's Get Started",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Create an account to Q Allure to get all features",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                hintText: "Enter your name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
              validator: (text) {
                if (text!.length < 6) {
                  return "Kamida 6 ta belgi kerak";
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              key: _formKey1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
                hintText: "Enter your email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
              onSaved: (e) {
                email = e;
              },
              validator: (text) {
                if (text!.length < 6) {
                  return "Kamida 6 ta belgi kerak";
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone_android,
                  color: Colors.blue,
                ),
                prefixText: "+998 ",
                labelText: "Enter your phone number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
              validator: (text) {
                if (text!.length != 9) {
                  return "Raqamni +998907374483 tartibda kiriting";
                }
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              key: _formKey2,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.visibility_off,
                  color: Colors.blue,
                ),
                hintText: "Enter your password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
              obscureText: true,
              onSaved: (p) {
                password = p;
              },
              validator: (text) {
                if (text!.length < 6) {
                  return "Kamida 6 ta belgi kerak";
                } else {
                  parolUshla = text;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              key: _formKey3,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.visibility_off,
                  color: Colors.blue,
                ),
                hintText: "Confirm your password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
              obscureText: true,
              validator: (text) {
                if (text.toString() != parolUshla.toString()) {
                  return "Parolni qayta terishda xatolik bo'ldi";
                }
              },
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Text(
                  "Create",
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              onPressed: _emailSignUp,
            ),
          ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(primary: Colors.orange),
          //   child: Text("Sign In Sahifasiga O't"),
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => LoginPage(),
          //     ),
          //   ),
          // ),
          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                ),
                child: Text(
                  "Login here",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _emailSignUp() async {
    if (_formKey1.currentState!.validate() &&
        _formKey2.currentState!.validate()) {
      _formKey1.currentState!.save();
      _formKey2.currentState!.save();
      print("Validatsiyadan o'tdi va save bo'ldi");
      print("$email");
      print("$password");
      try {
        UserCredential _credential = await _authUser
            .createUserWithEmailAndPassword(email: email!, password: password!);

        User _newUser = _credential.user!;
        await _newUser.sendEmailVerification();
        if (_authUser.currentUser != null) {
          await _authUser.signOut();
          await Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
        print(_newUser.email);
      } catch (e) {
        print("XATO: " + e.toString());
      }
    }
  }
}
