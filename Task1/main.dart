import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import the second screen

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: LoginScreen(),
));

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                String email = emailController.text;
                String password = passwordController.text;

                if (email.isEmpty || !email.contains('@')) {
                  showMessage(context, "Enter a valid email");
                } else if (password.isEmpty) {
                  showMessage(context, "Enter your password");
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              },
            ),
            TextButton(
              onPressed: () {
                // Optional forgot password action
                showMessage(context,"Remember it next time");
              },
              child: Text("Forgot Password?"),
            ),
          ],
        ),
      ),
    );
  }

  void showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

