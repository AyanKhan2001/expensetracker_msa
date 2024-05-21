import 'package:expensetracker_msa/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _agreeToTerms = false;
  bool _isObscure = true;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Color _signupButtonColor = Colors.greenAccent;
  Color _googleButtonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: const BorderSide(
                      color: Colors.white70, // border color
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: const BorderSide(
                      color: Colors.grey, // border color
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: const BorderSide(
                        color: Colors.white70, // border color
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value!;
                        _signupButtonColor = _agreeToTerms ? Colors.greenAccent : Colors.greenAccent ;
                        _googleButtonColor = _agreeToTerms ? Colors.white : Colors.white;
                      });
                    },
                    checkColor: Colors.greenAccent,
                  ),
                  Flexible(
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'By signing up, you agree to the ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Terms of Service and Privacy Policy',
                            style: TextStyle(color: Colors.black), // Link color
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _agreeToTerms ? _signup : null,
                style: ElevatedButton.styleFrom(
                  primary: _signupButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: Center(child: Text('Signup',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.black),)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Or with',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _agreeToTerms ? _signupWithGoogle : null,
                icon: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
                  height: 24,
                ),
                label: const SizedBox(
                  width: 220,
                  height: 50.0, // Set the desired height
                  child: Center(child: Text('Signup with Google',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black
                  ),)),
                ),
                style: ElevatedButton.styleFrom(
                  primary: _googleButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _signup() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User signed up: ${userCredential.user!.uid}');
    } catch (e) {
      print('Failed to sign up: $e');
    }
  }
  void _signupWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      print('User signed in with Google: ${userCredential.user!.uid}');
    } catch (e) {
      print('Failed to sign in with Google: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: SignupScreen(),
  ));
}
