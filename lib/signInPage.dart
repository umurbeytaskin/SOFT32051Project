import 'package:flutter/material.dart';
import 'package:voting_app/homePage.dart';
import 'package:voting_app/user.dart';
import 'package:voting_app/userManager.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({final Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFededed),
      body: body(),
      floatingActionButton: fab(),
    );
  }

  Widget body() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 64.0),
          child: Center(
            child: Text(
              "E-Voting System",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 64),
          child: customTextField("Username", false, userName),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 64),
          child: customTextField("Password", true, password),
        ),
      ],
    );
  }

  Widget customTextField(final String hintText, final bool psw,
      final TextEditingController controller) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        width: MediaQuery.of(context).size.width / 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            controller: controller,
            obscureText: psw,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget fab() {
    return FloatingActionButton(
      elevation: 4,
      backgroundColor: Colors.white,
      onPressed: () async {
        await UserManager.login(userName.text, password.text);
        if (User.self != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
        }
      },
      child: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.black38,
      ),
    );
  }
}
