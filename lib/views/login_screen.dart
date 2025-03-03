import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/firebase_helper.dart';
import 'package:flutter_application_1/views/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final AuthHelper authhelper = AuthHelper();

    void handleSignin() async {
      String? msg = await authhelper.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),

      );
      if (msg == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Login Successfull" )));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen(email: emailController.text);
            },
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Invalid Email or Password")));
      }
    }
  void handleSignUp() async {
    print(emailController.text);
    print(passwordController.text);
      String? msg = await authhelper.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      print(msg);
      if (msg == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Sign Up Successful")));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen(email: emailController.text);
            },
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Invalid Email or Password")));
      }
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            Text(
              "Intern Manager",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 300.0,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email',
                ),
              ),
              // TextField(controller: passwordController,decoration: InputDecoration(labelText: 'Password'),),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 300.0,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password',
                ),
              ),
            ),
            SizedBox(height: 10),
          Center(
          child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,

           children: [ 
            TextButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {handleSignUp();},
              child: Text('Sign Up'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {handleSignin();},
              child: Text('Login'),
            ),
          ]
          )
          )
          ],
        ),
      ),
    );
  }
}
