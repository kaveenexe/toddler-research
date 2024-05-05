import 'package:flutter/material.dart';
import 'package:flutterapp/components/Login/login_textfield.dart';
import 'package:flutterapp/components/Login/sign_in_out_button.dart';
import 'package:flutterapp/components/Login/squre_tile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset(
                  "assets/logo.png",
                  scale: 1.2,
                ),
                SizedBox(height: 30,),
                const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    "Sign Into Your Account",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 10),
                // Login Fields

                // Email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        LoginTextField(
                          controller: emailController,
                          hintText: "Enter your email",
                          obscureText: false,
                        ),
                      ]),
                ),

                const SizedBox(
                  height: 20,
                ),

                // Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Password",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        LoginTextField(
                          controller: passwordController,
                          hintText: "Enter your password",
                          obscureText: true,
                        ),
                      ]),
                ),

                const SizedBox(
                  height: 35,
                ),

                // Sign In Button
                SignInButton(
                  text: "SIGN IN",
                  onTap: () {},
                ),

                // Divider and Text
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          )),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          )),
                    ],
                  ),
                ),



                const SizedBox(
                  height: 15,
                ),

                // Don't have account - REGISTER
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",
                        style:
                        TextStyle(color: Color(0xff888888), fontSize: 14)),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: const Text(
                            "SIGN UP",
                            style: TextStyle(color: Color(0xff00B140)
                            )
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
