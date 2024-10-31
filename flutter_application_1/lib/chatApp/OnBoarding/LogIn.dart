import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chatPage.dart';
import 'SignUp.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool _isPasswordVisible = false;
  late SharedPreferences _prefs;

  @override
  void initState() {
    // TODO: implement initState
    _initializePrefs();
  }
  void _NavigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context ) => SignupPage()));
  }

  void _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _login() async {
    final username = usernamecontroller.text;
    final password = passwordcontroller.text;

    String? savedusername = _prefs.getString('username');
    String? savedpassword = _prefs.getString('password');

    if (savedusername == username && savedpassword == password) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ChatPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Color(0xFFFFF8E1)),
        child: Scaffold(
          body: SingleChildScrollView(
            child: _page1(),
          ),
        ));
  }

  Widget _page1() {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _txt(),
          const SizedBox(
            height: 100,
          ),
          _inputField(" user name", usernamecontroller),
          const SizedBox(
            height: 30,
          ),
          _inputField(" password", passwordcontroller, isPassword: true),
          const SizedBox(
            height: 5,
          ),
          _FgtPass(),
          const SizedBox(
            height: 50
          ),
          _SgnIn(),
          const SizedBox(
              height: 10
          ),
          _SgnUp(),
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
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      controller: controller,
      obscureText: isPassword ? !_isPasswordVisible : false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.deepPurpleAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.green),
        ),
        suffixIcon: isPassword
            ? IconButton(
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            icon: Icon(_isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off))
            : null,
      ),
    );
  }

  Widget _FgtPass() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text(
            "Forget Password?",
            style: TextStyle(
              color: Colors.grey,
              // fontFamily: 'AIR',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }

  Widget _SgnIn() {
    return ElevatedButton(onPressed: _login,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurpleAccent,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),

        child: SizedBox(
          width: double.infinity,
          child: Text("Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
            fontSize: 25,
            // fontFamily: 'AIR',
            fontWeight: FontWeight.w800,

          ),),

        ));
  }

  Widget _SgnUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?",
          style: TextStyle(
            // fontFamily: 'AIR',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        TextButton(onPressed: _NavigateToSignUp,

            child:  Text("Sign Up",
    style: TextStyle(
    // fontFamily: 'AIR',
    fontWeight: FontWeight.w800,
    fontSize: 14,
    color: Colors.deepPurpleAccent
    ),
    ),
        )

      ],

    );
  }


}
