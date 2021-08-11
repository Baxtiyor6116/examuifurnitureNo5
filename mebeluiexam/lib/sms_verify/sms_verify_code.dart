import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mebeluiexam/UI/main_page.dart';
import 'package:mebeluiexam/main.dart';

FirebaseAuth _authUser = FirebaseAuth.instance;

class VerifySmsCode extends StatefulWidget {
  String? phone;
  String? verificationId;
  VerifySmsCode(this.phone, this.verificationId, {Key? key}) : super(key: key);

  @override
  _VerifySmsCodeState createState() => _VerifySmsCodeState();
}

class _VerifySmsCodeState extends State<VerifySmsCode> {
  TextEditingController smsCode = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authUser.verifyPhoneNumber(
        phoneNumber: widget.phone!,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException credential) {},
        codeSent: (String verificationId, int? resendToken) async {},
        codeAutoRetrievalTimeout: (String text) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sms Kiriting !"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                controller: smsCode,
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Bo'sh Bolmasligi Kerak !";
                  }
                },
              ),
              ElevatedButton(
                onPressed: _phoneVerify,
                child: Text("Sms Verify"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _phoneVerify() async {
    print(smsCode.text);
    print(widget.verificationId);
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId!, smsCode: smsCode.text);
    await _authUser.signInWithCredential(phoneAuthCredential);
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}

  // phoneverification() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //   }
  // }
