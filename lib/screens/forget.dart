import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:net_login/screens/signup.dart';

final fireBase = FirebaseAuth.instance;

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Forget();
  }
}

class _Forget extends State<Forget> {
  final formKey = GlobalKey<FormState>();
  var _email;
  bool check = false;

  void _submit() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      formKey.currentState!.save();
      try {
        final userEmail = fireBase.sendPasswordResetEmail(email: _email);
        setState(() {
          check = true;
        });
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? "Authentication Failed"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(
          margin: const EdgeInsets.only(left: 15),
          child: Image.asset("assets/images/pngwing.com.png"),
        ),
        leadingWidth: 100,
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 40),
            child: Form(
              key: formKey,
              child: !check
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            style: TextStyle(
                                color: Color.fromARGB(225, 163, 160, 160),
                                fontSize: 17),
                            "We will send you an email with the instructions on how to reset you password."),
                        const SizedBox(
                          height: 25,
                        ),

                        TextFormField(
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(15, 40, 0, 0),
                            labelText: "Enter the email..",
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 163, 160, 160),
                              fontSize: 18,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Color.fromARGB(255, 32, 31, 32),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains("@")) {
                              return "Please enter a valid email address";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _email = value;
                          },
                        ),

                        //
                        const SizedBox(
                          height: 20,
                        ),
                        OutlinedButton(
                          onPressed: _submit,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Color.fromARGB(255, 83, 81, 81),
                                width: 2),
                            foregroundColor: Colors.white,
                            // backgroundColor: Color.fromARGB(255, 24, 45, 160),
                            fixedSize: const Size(400, 55),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Send",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const Text(
                            style: TextStyle(
                                color: Color.fromARGB(225, 163, 160, 160),
                                fontSize: 20),
                            "We have sent you the instructions on the email."),
                        const SizedBox(
                          height: 20,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Color.fromARGB(255, 83, 81, 81),
                                width: 2),
                            foregroundColor: Colors.white,
                            // backgroundColor: Color.fromARGB(255, 24, 45, 160),
                            fixedSize: const Size(400, 55),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Back to Login",
                            style: TextStyle(fontSize: 20),
                          ),
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
