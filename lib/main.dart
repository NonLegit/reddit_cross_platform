import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './post/widgets/post.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.copyWith(
        brightness: Brightness.dark,
        colorScheme: theme.colorScheme.copyWith(
            primary: Colors.white,
            onPrimary: Colors.black,
            secondary: Colors.grey,
            surface: Colors.black87,
            onSurface: Colors.white),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Post'),
          // elevation: 0,
        ),
        body: Post.home(data: {}),
      ),
    );
  }
}
