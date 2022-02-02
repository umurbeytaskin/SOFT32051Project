import 'package:flutter/material.dart';
import 'package:voting_app/pollCreatePage.dart';
import 'package:voting_app/pollListPage.dart';
import 'package:voting_app/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text("E-Voting System"),
      backgroundColor: Colors.grey,
    );
  }

  Widget _body() {
    return Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Hello to E-Voting System " + User.self!.userName,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32),
          ),
        ),
        const SizedBox(
          height: 64,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PollCreatePage(),
                  ));
            },
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(
                      child: Text(
                    "Create Poll",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PollListPage(),
                ),
              );
            },
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(
                      child: Text(
                    "Poll List",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
