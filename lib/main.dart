import 'package:flutter/material.dart';
import 'package:smartrep_ai_flutter_app/screens/auth_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Make main an async function
  WidgetsFlutterBinding.ensureInitialized(); // Required for async operations before runApp

  // Initializes Supabase with my project URL and Anon Key
  await Supabase.initialize(
    url: 'https://sckbcgxrebtmxozplmke.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNja2JjZ3hyZWJ0bXhvenBsbWtlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEyMDIwNjcsImV4cCI6MjA2Njc3ODA2N30.rCsHHG832qIKbrxxEvkIGVxCLpXJsd-NbCKvXgR_sxs',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartRep AI App', // App title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary color for the app
      ),
      home: const AuthScreen(), // Sets the home screen to AuthScreen,
    );
  }
}
