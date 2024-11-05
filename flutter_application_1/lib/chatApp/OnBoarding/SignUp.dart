import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  TextEditingController emailaddress = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isPasswordMismatch = false;
  late SharedPreferences _prefs;

  @override
  void initState() {
    // TODO: implement initState
    _initializePrefs();
  }

  void _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _saveData(String username, String emailaddress,
      String password) async {

    await _prefs.setString("username", username);
    await _prefs.setString("emailaddress", emailaddress);
    await _prefs.setString("password", password);
  }

  void _navigateToback() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Color(0xFFFFF8E1)),
        child: Scaffold(

          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              width: 40,
              height: 40,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Colors.white,
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                onPressed: _navigateToback,
                elevation: 0.5,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: _page2(),
          ),
        ));
  }

  Widget _page2() {
    return Padding(
      padding: EdgeInsets.only(top: 80, left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _txt(),
          const SizedBox(
            height: 100,
          ),

          _InputField("User Name ", username),
          const SizedBox(
            height: 30,
          ),
          _InputField("Enter you email", emailaddress),
          const SizedBox(
            height: 30,
          ),
          _InputField("Enter your password", password,isPassword: true),
          const SizedBox(
            height: 30,
          ),
          _InputField("Confirm your password ", confirmPassword,isPassword: true,isConfirmPassword: true),
          const SizedBox(
              height: 60
          ),
          _SignUp(),



        ],
      ),
    );
  }

  Widget _txt() {
    return const Padding(
      padding: EdgeInsets.only(left: 125, right: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }


  Widget _InputField(String hintText, TextEditingController controller, {bool isPassword = false, bool isConfirmPassword = false}) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      controller: controller,
      obscureText: isPassword ? !(isConfirmPassword ? _isConfirmPasswordVisible : _isPasswordVisible) : false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        errorText: isConfirmPassword && _isPasswordMismatch ? "Passwords do not match" : null, // Show error message if passwords mismatch
        errorStyle: const TextStyle(color: Colors.red),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: _isPasswordMismatch && isConfirmPassword ? Colors.red : Colors.deepPurpleAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: _isPasswordMismatch && isConfirmPassword ? Colors.red : Colors.green),
        ),
        suffixIcon: isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              if (isConfirmPassword) {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              } else {
                _isPasswordVisible = !_isPasswordVisible;
              }
            });
          },
          icon: Icon(
            (isConfirmPassword ? _isConfirmPasswordVisible : _isPasswordVisible)
                ? Icons.visibility
                : Icons.visibility_off,
          ),
        )
            : null,
      ),
    );
  }

  Widget _SignUp() {
    return ElevatedButton(  onPressed: () {
      setState(() {
        _isPasswordMismatch = password.text != confirmPassword.text; // Check if passwords match
      });

      if (!_isPasswordMismatch) {
        _saveData( username.text, emailaddress.text, password.text);
        // Additional sign-up logic here
      } else {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords do not match!")),
        );
      }
    },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurpleAccent,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),

        child: SizedBox(
          width: double.infinity,
          child: Text("Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              // fontFamily: 'AIR',
              fontWeight: FontWeight.w800,

            ),),

        ));

  }

}
