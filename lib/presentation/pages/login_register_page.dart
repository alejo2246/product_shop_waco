import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:product_shop/data/repositories/auth_repository.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  AuthRepository get _authRepository =>
      Provider.of<AuthRepository>(context, listen: false);

  Future<void> signInWithEmailAndPassword() async {
    try {
      await _authRepository.signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> signInGoogle() async {
    try {
      await _authRepository.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await _authRepository.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? "Login" : "Register"),
    );
  }

  Widget _loginOrRegisterButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: Text(isLogin ? "Register instead" : "Login instead"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Forgot Password?"),
        ),
      ],
    );
  }

  Widget _submitButtonGoogle() {
    return ElevatedButton.icon(
      onPressed: signInGoogle,
      icon: Image.asset(
        "assets/images/google_logo.webp",
        width: 24,
        height: 24,
      ),
      label: const Text("Login with Google"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: 200,
            ),
            _entryField('Email', _controllerEmail),
            _entryField('Password', _controllerPassword),
            Text(errorMessage == '' ? '' : 'Hmmm? $errorMessage'),
            _loginOrRegisterButton(),
            _submitButton(),
            const SizedBox(height: 20),
            const Text('Or continue with'),
            const SizedBox(height: 10),
            _submitButtonGoogle(),
          ],
        ),
      ),
    );
  }
}
