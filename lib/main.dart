// Part 1: Importing necessary packages and libraries
// The are the essential imports for my Flutter application
// 'package:flutter/material.dart' is used for building the UI components like buttons, text, themes, etc.
// 'packcage:smartrep_ai_flutter_app/screens/auth_screen.dart' is the AuthScreen widget, which will be the first screen (login/signup) shown to the user.
// 'package:smartrep_flutter/supabase_flutter.dart' is the Supabase package, which provides backend services like authentication, database access, and real-time capabilities.
import 'package:flutter/material.dart';
import 'package:smartrep_ai_flutter_app/screens/auth_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


// Part 2: Main function and MyApp class
// This is the entry point of the Flutter application.
// 'Future' is used to indicate that this function will perform asynchronouse operations.
// 'void' means this function does not return any value.
// 'main()' is the main function that runs when the app starts.
// async is used to allow the use of 'await' for asynchronous operation inside the function.
Future<void> main() async {
  // 'WidgetsFlutterBinding' is a class that finds the Flutter engine and connects it to the framework.
  //This line ensures that the Flutter engine is fully initialized and is required when doing async setup before calling runApp().
  WidgetsFlutterBinding.ensureInitialized();

  // This line initializes Supabase by connecting to my specific project using the provided URL and Anon Key.
  // This is where the app sets up backend communication (authentication, database, etc.).
  // 'url' is the unuqie URL of my Supabase project, which is used to connect to the backend services.
  // 'anonKey' is the public API key for my Supabase project, which allows the app to access the backend services securely.
  await Supabase.initialize(
    url: 'https://sckbcgxrebtmxozplmke.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNja2JjZ3hyZWJ0bXhvenBsbWtlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEyMDIwNjcsImV4cCI6MjA2Njc3ODA2N30.rCsHHG832qIKbrxxEvkIGVxCLpXJsd-NbCKvXgR_sxs',
  );

  // This line runs the main app widget, which is MyApp.
  //'runApp' is a Flutter function that takes a widget and makes it the root of the widget tree; Meaning, it starts the Flutter appplication and displays the UI on the screen.
  runApp(const MyApp());
}


// Part 3: Root Widget of the Application
// 'MyApp' is a StatelessWidget, which means it does not have a mutable state (it does not change over time).
// StatelessWidget is a type of widget that does not require mutable state (it also does not change over time).
class MyApp extends StatelessWidget {
  const MyApp({
    // 'super.key' is used to pass the key to the parent class (StatelessWidget).
    super.key,
  });
// This is the build method, which is called when the widget is created.
// It returns a MaterialApp widget, which is the root of the application and provides basic app structure and functionality.
// 'title' is the name of the app.
// 'theme' defines the overall look and feel of the app, including colors, fonts, etc.
// 'home' is the first screen that the user sees when they open the app, which in this case I've set to the AuthScreen widget.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          'SmartRep AI App', // The title of the app
      theme: ThemeData(
        primarySwatch:
            Colors.blue, // Defines the primary theme color for the app
      ),
      home: const AuthScreen(),
    );
  }
}
