import 'package:flutter/material.dart';
import 'package:travel_app/services/login_services.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final socialAuth = SocialAuth();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LoginTextField(
                  label: 'Email',
                ),
                const LoginTextField(
                  label: 'password',
                ),
                GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 152, 240, 255)),
                    child: const Center(
                      child: Text('Login',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 16, 30, 160),
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FloatingActionButton.extended(
                  onPressed: () {
                    socialAuth.signupGoogle(context);
                  },
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  label: Row(
                    children: [
                      Image.asset(
                        'assets/icon/googleLogin.png',
                        height: 35,
                      ),
                      const Text(
                        'Login with Google',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: TextField(
        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
                color: Colors.black45, fontWeight: FontWeight.w500),
            fillColor: Color.fromARGB(255, 152, 240, 255).withOpacity(0.3),
            filled: true,
            contentPadding: const EdgeInsets.all(20),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: const Color.fromARGB(255, 55, 137, 231),
                    width: 1.6))),
      ),
    );
  }
}
