import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:total_app/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ykgcleziuyxkqzunjjpu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlrZ2NsZXppdXl4a3F6dW5qanB1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMzODA4NTMsImV4cCI6MjA0ODk1Njg1M30.MLWG6N6NfhXUBO-SZTByjsYHUMZTzmuZ9tEtXFXaH7Q',
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
