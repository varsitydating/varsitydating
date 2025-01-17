import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varsitydating/widgets/login_buttons_widget.dart';
import 'package:varsitydating/authenticationScreen/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();
  bool showProgressBar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),

              Image.asset(
                "images/logo.png",
                width: 200,
              ),

              const Text(
                "Welcome to Varsity Dating",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              Center(
                child: const Text(
                  "The campus is buzzing, login to connect with your crush on Varsity Dating!",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),


              const SizedBox(
                height: 28,
              ),

              //email
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: 55,
                child: LoginButtonsWidget(
                  editingController: emailtextEditingController,
                  labelText: "Email",
                  iconData: Icons.email_outlined,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 22,
              ),

              //password
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: 55,
                child: LoginButtonsWidget(
                  editingController: passwordtextEditingController,
                  labelText: "Password",
                  iconData: Icons.lock_outline,
                  isObscure: true,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              //login button
              Container(
                width: MediaQuery.of(context).size.width - 30,
                height: 50,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(247, 122, 84, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    )),
                child: InkWell(
                  onTap: () {},
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              //Don't have an account? SignUp here button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(RegistrationScreen());
                    },
                    child: const Text(
                      "SignUp Here",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 18,
              ),

              showProgressBar == true
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.deepOrangeAccent),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
