import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:net_login/screens/home.dart';

final fireBase = FirebaseAuth.instance;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Signup();
  }
}

class _Signup extends State<Signup> {
  final fKey = GlobalKey<FormState>();
  bool _vari = false;
  bool isLogin = false;

  var _email;
  var _password;

  void _submit() async {
    final isValid = fKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      fKey.currentState!.save();
      try {
        final userCredentials = await fireBase.createUserWithEmailAndPassword(
            email: _email, password: _password);
        setState(() {
          isLogin = true;
        });
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (error) {
        isLogin = false;
        // ScaffoldMessenger.of(context).clearSnackBars();
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
        title: Image.asset(
          "assets/images/pngwing.com.png",
          width: 100,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.cennter,
            children: [
              const Text(
                "Unlimited movies, TV shows & more",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 0),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Create an account and we'll send you an email with everything you need to know about Netflix.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 0),
              ),
              const SizedBox(
                height: 17,
              ),
              Form(
                key: fKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 147, 219, 156),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value!.trim().isEmpty ||
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
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 147, 219, 156)),
                        ),
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
                      height: 10,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _vari,
                          onChanged: (value) {
                            setState(() {
                              _vari = !_vari;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                              "Please do not email me Netflix special offers"),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                        ),
                        fixedSize: const Size(
                          400,
                          45,
                        ),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: isLogin
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "CREATE ACCOUNT",
                              style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w400),
                            ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
