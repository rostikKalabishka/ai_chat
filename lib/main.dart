import 'package:ai_chat/configs/firebase_options.dart';
import 'package:ai_chat/screens/auth/sign_in/view/sign_in_screen.dart';
import 'package:ai_chat/screens/auth/sign_up/view/sign_up.dart';
import 'package:ai_chat/screens/chat/view/chat_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/ui/theme/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Chat',
      theme: darkTheme,
      home: ChatScreen(),
    );
  }
}
