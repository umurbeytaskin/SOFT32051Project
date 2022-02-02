import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/signInPage.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: const MaterialApp(
      home: SignInPage(),
    ),
  ));
}
