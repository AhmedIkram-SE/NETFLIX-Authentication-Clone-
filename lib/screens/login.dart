import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:net_login/screens/forget.dart';
import 'package:net_login/screens/signup.dart';

final fireBase = FirebaseAuth.instance;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  final formKey = GlobalKey<FormState>();
  var _email;
  var _password;

  void _submit() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      formKey.currentState!.save();
      try {
        final userCredentials = await fireBase.signInWithEmailAndPassword(
            email: _email, password: _password);
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
          margin: EdgeInsets.only(left: 15),
          child: Image.asset("assets/images/pngwing.com.png"),
        ),
        leadingWidth: 100,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(15, 47, 0, 0),
                        labelText: "Email or phone number",
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
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(15, 47, 0, 0),
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 163, 160, 160),
                          letterSpacing: 0,
                          fontSize: 18,
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
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 6) {
                          return "Please enter a valid password";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    OutlinedButton(
                      onPressed: _submit,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color.fromARGB(255, 83, 81, 81), width: 2),
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
                        "Sign In",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 163, 160, 160),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 32, 31, 32),
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
                        "Use a Sign-In code",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const Forget();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Color.fromARGB(255, 163, 160, 160),
                            fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const Signup();
                            },
                          ),
                        );

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return const Signup();
                        //     },
                        //   ),
                        // );
                      },
                      child: const Text(
                        "New to Netflix? Sign Up now",
                        style: TextStyle(
                            color: Color.fromARGB(255, 163, 161, 161),
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
