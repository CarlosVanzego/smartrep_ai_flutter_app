// Part 1: Importing necessary packages and libraries
// These imports are required to build the UI, handle navigation, and manage authentication with Supabase.
// 'package:flutter/material.dart' provides Flutter's Material Design widgets and tools.
// 'package:supabase_flutter/supabase_flutter.dart' allows authentication and database access through Supabase.
// 'package:smartrep_ai_flutter_app/screens/auth_screen.dart' imports the AuthScreen widget for navigating after sign-out.
// 'package:smartrep_ai_flutter_app/screens/ai_input_screen.dart' imports the AiInputScreen widget for AI input functionality.
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:smartrep_ai_flutter_app/screens/auth_screen.dart';
import 'package:smartrep_ai_flutter_app/screens/ai_input_screen.dart';


// Part 2: DashboardScreen Widget
// This StatefulWidget provides the main dashboard interface after the user logs in.
// StatefulWidget is used because the UI may change dynamically (e.g., showing snackbars or navigating between screens).
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}


// Part 3: _DashboardScreenState Class
// Holds the mutable state for DashboardScreen, including Supabase client and sign-out functionality.
class _DashboardScreenState extends State<DashboardScreen> {
  // Supabase client instance to handle authentication
  final supabase = Supabase.instance.client;


  // Part 4: Sign-out Method
  // Signs the user out and navigates back to the AuthScreen
  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut(); // Call Supabase signOut method

      // After signing out, navigate to the AuthScreen
      if (mounted) { // Ensure widget is still in the widget tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AuthScreen()),
        );
      }
    } on AuthException catch (e) {
      // Catch authentication-related errors
      _showSnackBar(e.message);
    } catch (e) {
      // Catch unexpected errors
      _showSnackBar('An unexpected error occurred: $e');
    }
  }


  // Part 5: Helper Method for Snackbars
  // Displays temporary messages at the bottom of the screen for user feedback
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }


  // Part 6: Build Method
  // Builds the UI for the dashboard screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar at the top of the screen
      appBar: AppBar(
        title: const Text('SmartRep AI Dashboard'), // AppBar title
        actions: [
          // Logout button in the AppBar
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut, // Calls sign-out method
            tooltip: 'Logout',
          ),
        ],
      ),

      // Body content centered on the screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          children: [
            // Welcome message
            const Text(
              'Welcome to your SmartRep AI Dashboard!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // Space between texts

            // Placeholder text for additional content
            const Text('More content and AI features will go here.'),
            const SizedBox(height: 30), // Space before button

            // Button to navigate to AI input screen
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AiInputScreen()),
                );
               },
              icon: const Icon(Icons.auto_awesome), // Button icon
              label: const Text('Go to AI Processing'), // Button text
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Button padding
                textStyle: const TextStyle(fontSize: 18), // Button text size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
