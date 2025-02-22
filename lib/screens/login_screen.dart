import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterfirebasetest/firebase_options.dart';
import 'package:flutterfirebasetest/methods/auth_methods.dart';
import 'package:flutterfirebasetest/screens/bottom_nav_screen.dart';
import 'package:flutterfirebasetest/screens/signup_screen.dart';
import 'package:flutterfirebasetest/screens/verification.dart';
import 'package:flutterfirebasetest/widgets/custom_button.dart';
import 'package:flutterfirebasetest/widgets/custom_textfield.dart';
import 'package:flutterfirebasetest/widgets/loading.dart';
import 'package:flutterfirebasetest/widgets/space.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login-screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    const Verification();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String error = "";

  Future signIn() async {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      setState(() {
        loading = true;
      });

      await AuthMethods().loginUser(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const BottomNavScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, top: 60),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: FutureBuilder(
                      future: Firebase.initializeApp(
                        options: DefaultFirebaseOptions.currentPlatform,
                      ),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                              child: SpinKitWave(
                                color: Color.fromARGB(255, 191, 0, 255),
                              ),
                            );

                          case ConnectionState.done:
                            return Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const Space(),
                                  Image(
                                    image: const AssetImage(
                                      "assets/logo/logo.png",
                                    ),
                                    // height: MediaQuery.of(context).size.height * 0.2,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                  ),
                                  const SizedBox(height: 30),
                                  MyTextField(
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter an Email";
                                      }
                                      if (!RegExp(
                                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                          .hasMatch(value)) {
                                        return "Invalid Email !";
                                      }
                                      return null;
                                    },
                                    inputType: TextInputType.emailAddress,
                                    label: "Email",
                                    controller: emailController,
                                    obscure: false,
                                  ),
                                  const Space(),
                                  StatefulBuilder(
                                    builder: (context, setState) {
                                      return MyTextField(
                                        obscure: !_isVisible,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _isVisible = !_isVisible;
                                            });
                                          },
                                          icon: _isVisible
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off),
                                        ),
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter Password";
                                          }
                                          if (value.length < 6) {
                                            return "Password is Short";
                                          }
                                          return null;
                                        },
                                        inputType: TextInputType.text,
                                        label: "Password",
                                        controller: passwordController,
                                      );
                                    },
                                  ),
                                  const Space(),
                                  CustomButton(
                                    onTap: signIn,
                                    label: "Login",
                                  ),
                                  const SizedBox(height: 30),
                                  Wrap(
                                    spacing: 20,
                                    direction: Axis.horizontal,
                                    children: [
                                      TextButton(
                                        onPressed: () => Navigator.pushNamed(
                                          context,
                                          SignUpScreen.routeName,
                                        ),
                                        child: const Text("Create an Account"),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );

                          default:
                            return const Text("Loading.......");
                        }
                      }),
                ),
              ),
            ),
          );
  }
}
