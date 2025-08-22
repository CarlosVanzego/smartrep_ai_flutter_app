// Part 1: Importing necessary packages and libraries
// These are the core dependencies required for this service file.
// 'dart:convert' provides utilities to work with JSON, such as jsonEncode and jsonDecode.
// 'package:http/http.dart' is used to send HTTP requests (GET, POST, etc.) to the backend API.
// 'package:supabase_flutter/supabase_flutter.dart' is the Supabase SDK for authentication, database, and backend services.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';


// Part 2: AiService Class
// This class is responsible for handling communication between the Flutter app and the backend AI service.
// It uses Supabase for authentication and HTTP for sending/receiving data.
class AiService {
  // The base URL of the AI backend service.
  // Here it’s pointing to a local server running on my machine, accessible via Local IP: 192.168.1.72, port 5001.
  final String _baseUrl = 'http://192.168.1.72:5001';

  // Initialize Supabase client inside the class
  // 'supabase' gives access to authentication and database features of Supabase.
  // This ensures the Supabase client is ready to use whenever AiService is created.
  final SupabaseClient supabase;

  // Constructor of AiService
  // When AiService is instantiated, it initializes the Supabase client with 'Supabase.instance.client'.
  AiService() : supabase = Supabase.instance.client;


  // Part 3: processTextWithAI Method
  // This method sends a user’s input text to the AI backend and returns the AI’s response.
  // 'Future<String>' means it runs asynchronously and eventually returns a String result.
  // 'processTextWithAI' takes a String 'text' as input, which is the user’s message to the AI.
  Future<String> processTextWithAI(String text) async {
    // Construct the URI for the AI service endpoint
    // 'uri' is created by parsing the base URL and appending '/api/chat'.
    // 'Uri.parse()' converts the string URL into a Uri object, which is required for making HTTP requests.
    // '$_baseUrl/api/chat' is the endpoint where the AI service listens for requests.
    final uri = Uri.parse('$_baseUrl/api/chat');

    // Here I am getting the access token from the currently logged-in Supabase session
    // 'String?' indicates that accessToken can be null if the user is not authenticated.
    // 'accessToken' retrieves the current session's access token from Supabase.
    // 'supabase.auth.currentSession?.accessToken' checks if the user is logged in and retrieves the token.
    final String? accessToken = supabase.auth.currentSession?.accessToken;

    // If there is no access token, the user is not logged in and an I throw an error.
    if (accessToken == null) {
      throw Exception('User not authenticated. Please log in.');
    }

    try {
      // This line prepares the request body with conversation history
      // 'List<Map<String, dynamic>> history' is a list containing a single map.
      // 'history' contains the conversation history, which includes the user's input text.
      // 'role: user' indicates that this part of the conversation is from the user.
      // 'parts' is a list of parts of the message, where each part is a map with a 'text' key.
      // 'text' is the actual user input that will be sent to the AI service.
      final List<Map<String, dynamic>> history = [
        {
          "role": "user",
          "parts": [
            {"text": text},
          ],
        },
      ];

      // Here I am sending an HTTP POST request to the backend AI service
      // 'headers' include content type (JSON) and authorization token for secure access.
      // 'body' contains the encoded conversation history.
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(<String, dynamic>{'history': history}),
      );

      // This line checks if the response from the backend is successful (status code 200 = OK; 400 = Bad Request; 500 = Internal Server Error).
      // If the response is successful, it decodes the JSON response and returns the AI's response text.
      if (response.statusCode == 200) {
        // This line decodes the response body into a Map.
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Return the AI’s response text.
        // If no text is found, return a fallback message.
        return data['text'] ?? 'No AI response found.';
      } else {
        // If the response is not 200, log the error details to the console for debugging.
        print('--- FLUTTER: AI Service Error Response ---');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        print('--- END AI Service Error Response ---');

        // Throw an exception so the app knows the request failed.
        throw Exception('Failed to process text: ${response.body}');
      }
    //Catch any errors during the request (e.g., server offline, no internet).
    } catch (e) {
      print('Error calling AI service: $e');

      // Throw a new exception to inform the app that the connection failed.
      throw Exception('Failed to connect to AI service: $e');
    }
  }
}
