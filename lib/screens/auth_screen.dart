// Part 1: Importing necessary packages and libraries
// These imports are required to build the UI and handle authentication with Supabase.
// 'package:flutter/material.dart' provides Flutter's Material Design widgets and tools.
// 'package:supabase_flutter/supabase_flutter.dart' allows authentication and database access through Supabase.
// 'package:smartrep_ai_flutter_app/screens/dashboard_screen.dart' imports the DashboardScreen widget, which users see after successful login.
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:smartrep_ai_flutter_app/screens/dashboard_screen.dart';


// Part 2: AuthScreen Widget
// This StatefulWidget provides the login/register interface for the app.
// StatefulWidget is used because the UI needs to update dynamically when the user interacts (loading state, form switching, etc.).
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}


// Part 3: _AuthScreenState Class
// Holds the mutable state for AuthScreen, including user input, loading state, and login/register toggle.
class _AuthScreenState extends State<AuthScreen> {
  // Controller to retrieve user input from email TextField
  final TextEditingController _emailController = TextEditingController();

  // Controller to retrieve user input from password TextField
  final TextEditingController _passwordController = TextEditingController();

  // Tracks if an API request is currently in progress to show a spinner
  bool _isLoading = false;

  // Determines whether the form is in login or registration mode
  bool _isRegistering = false;

  // Supabase client instance to handle authentication
  final supabase = Supabase.instance.client;


  // Part 4: Widget Lifecycle Methods
  // Dispose controllers to avoid memory leaks when the widget is removed from the widget tree.
  // 'void' means this method does not return any value.
  // 'dispose()' is called when the widget is removed from the widget tree.
  // '_emailController.dispose()' cleans up the email TextEditingController to free resources.
  // '_passwordController.dispose()' cleans up the password TextEditingController to free resources.
  // 'super.dispose()' calls the parent class's dispose method to ensure proper cleanup.
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  // Part 5: Helper Methods
  // Shows temporary messages at the bottom of the screen to give feedback to the user.
  // 'void' means this method does not return any value.
  // '_showSnackBar(String message)' takes a String 'message' as input, which is the message to display.
  // 'ScaffoldMessenger.of(context)' gets the current ScaffoldMessenger for showing SnackBars.
  // 'showSnackBar(SnackBar(content: Text(message)))' displays a SnackBar with the provided message.
  // 'SnackBar' is a widget that shows a brief message at the bottom of the screen.
  // 'Text(message)' is the content of the SnackBar, which is the message to display.
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }


  // Part 6: Authentication Methods
  // Handles logging in an existing user.
  // 'Future<void>' means this method runs asynchronously and does not return any value.
  // '_signIn()' is the method that performs the login operation.
  // 'setState()' is called to update the UI to show a loading spinner while the request is in progress.
  // '_isLoading' is set to true to indicate that a request is being processed.
  Future<void> _signIn() async {
    setState(() {
      _isLoading = true; // Show loading spinner
    });

    try {
      // Call Supabase signInWithPassword method with the user's credentials.
      // 'AuthResponse' is the response type that contains user information after login.
      // 'res' is the variable that holds the authentication response.
      // 'supabase.auth.signInWithPassword' is the method that performs the login operation
      // 'email' and 'password' are the user's credentials entered in the TextFields.
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // If login succeeds, this line shows a success message and navigates to the dashboard.
      if (res.user != null) {
        _showSnackBar('Logged in successfully!');
        if (mounted) { // Ensures the widget is still in the widget tree.
        // This line navigates to the DashboardScreen after successful login.
          Navigator.of(context).pushReplacement(
            // 'MaterialPageRoute' creates a route to the DashboardScreen.
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        }
      }
    // 'on AuthException catch (e)' catches authentication-related errors.
    } on AuthException catch (e) {
      // If an authentication error occurs, this line shows the error message in a SnackBar.
      _showSnackBar(e.message);
    } catch (e) {
      // This line catchs unexpected errors and shows a generic error message.
      _showSnackBar('An unexpected error occurred: $e');
    } finally {
      // This line resets the loading state.
      setState(() {
        _isLoading = false;
      });
    }
  }


  // This line handles registering a new user
  // 'Future<void>' means this method runs asynchronously and does not return any value.
  // '_signUp()' is the method that performs the registration operation.
  // 'setState()' is called to update the UI to show a loading spinner while the request is in progress.
  // '_isLoading' is set to true to indicate that a request is being processed.
  Future<void> _signUp() async {
    setState(() {
      _isLoading = true; // Show loading spinner
    });

    // Here I use a try statement to register a new user with Supabase 
    try {
      // Call Supabase signUp method with the user's credentials (email and password).
      final AuthResponse res = await supabase.auth.signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // If registration succeeds, show confirmation message
      if (res.user != null) {
        _showSnackBar('Registered successfully! Please check your email for confirmation.');
        // User remains on auth screen until they verify email
      }
    } on AuthException catch (e) {
      // Catch registration errors
      _showSnackBar(e.message);
    } catch (e) {
      // Catch unexpected errors
      _showSnackBar('An unexpected error occurred: $e');
    } finally {
      // Reset loading state
      setState(() {
        _isLoading = false;
      });
    }
  }


  // Part 7: Build Method
  // This method builds the UI for the login/register screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar at the top of the screen
      appBar: AppBar(
        title: Text('SmartRep AI - ${_isRegistering ? 'Register' : 'Login'}'), // Dynamically update title
        backgroundColor: Theme.of(context).primaryColor, // AppBar color from theme
      ),

      // Body content with padding
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch widgets horizontally
          children: [
            // Title text changes based on login/register mode
            Text(
              _isRegistering ? 'Create your account' : 'Welcome Back!',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40), // Space between title and input fields

            // Email input field
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress, // Show email keyboard
            ),
            const SizedBox(height: 16), // Space between email and password

            // Password input field
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true, // Hide password input
            ),
            const SizedBox(height: 24), // Space before button

            // Loading spinner or login/register button
            _isLoading
                ? const Center(child: CircularProgressIndicator()) // Show spinner while processing
                : ElevatedButton(
                    onPressed: _isRegistering ? _signUp : _signIn, // Call correct method
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16), // Button height
                      textStyle: const TextStyle(fontSize: 18), // Button text size
                    ),
                    child: Text(_isRegistering ? 'Register' : 'Login'),
                  ),
            const SizedBox(height: 10), // Space between button and toggle

            // Button to toggle between login and registration forms
            TextButton(
              onPressed: () {
                setState(() {
                  _isRegistering = !_isRegistering; // Switch form mode
                });
              },
              child: Text(_isRegistering ? 'Already have an account? Login' : 'New user? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
