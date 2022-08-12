import 'dart:async';
import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/viewModel/login_view_model.dart';
import 'package:flutter_template/views/pages/main/main_screen.dart';
import 'package:provider/provider.dart';

import '../../../Services/shared_preferences_service.dart';
import '../../../Services/shared_service.dart';

class LoginPage extends StatefulWidget {
  static const String id = "login_screen";
  static const path = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PrefService _prefService = PrefService();

  @override
  void initState() {
    _prefService.readCache("token").then((value) {
      print("login screen cache token : " + value.toString());
      if (value != null) {
        return Timer(const Duration(seconds: 2),
            () => context.beamToNamed(MainScreen.path));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Se connecter',
      color: Colors.blue,
      child: Scaffold(
        //backgroundColor: const Color(0xFFf5f5f5),
        body: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8),
          children: const [
            Menu(),
            // MediaQuery.of(context).size.width >= 980
            //     ? Menu()
            //     : SizedBox(), // Responsive
            SizedBox(
              height: 30,
            ),
            Body()
          ],
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _menuItem(title: 'About us'),
              _menuItem(title: 'Contact us'),
              _menuItem(title: 'Help'),
            ],
          ),
          Row(
            children: [
              _menuItem(title: 'Sign In', isActive: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuItem({String title = 'Title Menu', isActive = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 75),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.deepPurple : Colors.grey,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            isActive
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _registerButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            spreadRadius: 10,
            blurRadius: 5,
          ),
        ],
      ),
      child: const Text(
        'Register',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  var hidePassword = true;

  var _password = "1";
  var _username = "";
  var _submitActive = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            width: SizeConfig.screenWidth * 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Une assurance \npour chaque détail de votre vie',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Se connecter à \nGat tableau de board",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/illustration-2.png',
                  width: 300,
                ),
              ],
            ),
          ),
        ),

        Expanded(
          child: Image.asset(
            'assets/images/logoGat.png',
            width: SizeConfig.screenWidth * 0.3,
          ),
        ),
        // MediaQuery.of(context).size.width >= 1300 //Responsive
        //     ? Image.asset(
        //         'images/illustration-1.png',
        //         width: 300,
        //       )
        //     : SizedBox(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 6),
            child: SizedBox(
              width: SizeConfig.screenWidth * 0.35,
              child: _formLogin(context),
            ),
          ),
        )
      ],
    );
  }

  Widget _formLogin(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter an Email";
              }

              return null;
            },
            onSaved: (value) {
              setState(() {
                _username = value.toString();
              });
            },
            style: const TextStyle(color: bgColor),
            decoration: InputDecoration(
              hintText: 'Enter username',
              hintStyle: const TextStyle(color: Colors.black38),
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            obscureText: hidePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a Password";
              }

              return null;
            },
            onSaved: (value) {
              setState(() {
                _password = value.toString();
              });
            },
            style: const TextStyle(color: bgColor),
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: const TextStyle(color: Colors.black38),
              counterText: 'Forgot password?',
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  !hidePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
              ),
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[50]!),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple[100]!,
                  spreadRadius: 10,
                  blurRadius: 15,
                ),
              ],
            ),
            child: ElevatedButton(
              child: const SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(child: Text("Sign In"))),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  await context
                      .read<LoginViewModel>()
                      .Login(_username, _password);
                  var response = context.read<LoginViewModel>().loggedin;
                  log("---------------------------------------" +
                      response.toString());
                  if (response == true) {
                    context.beamToNamed(MainScreen.path);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('invalid credentials')),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
