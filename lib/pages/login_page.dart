import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/my_button.dart';
import 'package:the_wall/components/my_text_field.dart';
import 'package:the_wall/components/square_tile.dart';
import 'package:the_wall/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editnig controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      // //WRONG EMAIL OR PASSWORD
      wrongEmailorPasswordMessage(e.code);
    }
  }

  // wrong email or password message
  void wrongEmailorPasswordMessage(String errorCode) {
    String message = '';
    switch (errorCode) {
      case 'invalid-email':
        message = 'Invalid email address';
        break;
      case 'user-disabled':
        message = 'User disabled';
        break;
      case 'user-not-found':
        message = 'User not found';
        break;
      case 'wrong-password':
        message = 'Wrong password';
        break;
      default:
        message = 'Something went wrong';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          content:
              const Text('Please enter a valid email address and password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  //method of forgot password
  void forgotPassword() async {
    String email = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
            hintText: 'Enter your email',
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            email = value;
          },
        ),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),

          //send button
          TextButton(
            onPressed: () async {
              //send password reset email
              await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

              //pop the dialog
              Navigator.pop(context);
            },
            child: const Text('Send', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 50),

            //logo
            const Icon(Icons.lock, size: 100),
            const SizedBox(height: 50),

            //welcome back, you've been missed!
            Text('Welcome back you\'ve  been missed!',
                style: TextStyle(color: Colors.grey[700], fontSize: 16)),
            const SizedBox(height: 50),

            //email textfield
            MyTextField(
              controller: emailController,
              obscureText: false,
              hintText: 'Email',
            ),
            const SizedBox(height: 10),

            //password textfield
            MyTextField(
              controller: passwordController,
              obscureText: true,
              hintText: 'Password',
            ),
            const SizedBox(height: 10),

            //forgot password?
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //forgot password button
                    GestureDetector(
                      onTap: forgotPassword,
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                )),
            const SizedBox(height: 25),

            //sign in buttton
            MyButton(
              text: 'Sign in',
              onTap: signUserIn,
            ),
            const SizedBox(height: 50),

            //or continue with
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(thickness: 0.5, color: Colors.grey[400]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.00),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(thickness: 0.5, color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            //google + app sign in buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //google button
                SquareTile(
                  imagePath: 'lib/images/google.png',
                  onTap: () => AuthService().signInWithGoogle(),
                ),
                const SizedBox(width: 25),
                //apple button
                SquareTile(
                    imagePath: 'lib/images/black-apple.png', onTap: () {}),
              ],
            ),
            const SizedBox(height: 50),

            //not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member?',
                    style: TextStyle(color: Colors.grey[700])),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Registe NOW',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ]),
        ),
      )),
    );
  }
}
