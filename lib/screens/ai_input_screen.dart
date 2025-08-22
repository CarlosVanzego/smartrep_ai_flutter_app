// Part 1: Importing necessary packages and libraries
// These imports are required to build the UI and connect to the AI service.
// 'package:flutter/material.dart' provides Flutter's Material Design widgets and tools.
// 'package:smartrep_ai_flutter_app/services/ai_service.dart' imports the AiService class, which handles sending user input to the AI backend and receiving responses.
import 'package:flutter/material.dart';
import 'package:smartrep_ai_flutter_app/services/ai_service.dart';


// Part 2: AiInputScreen Widget
// This StatefulWidget is the screen where the user inputs text for AI processing.
// StatefulWidget is used here because the screen's content will change dynamically (loading state, AI result, etc.).
// 'AiInputScreen' is the main screen where users can enter text and interact with the AI service.
// 'StatefulWidget' is used because the screen will have mutable state (like loading status and AI response).
// 'super.key' is used to pass the key to the parent class.
class AiInputScreen extends StatefulWidget {
  const AiInputScreen({super.key});

//'override' indicates that this method is overriding a method from the parent class (StatefulWidget).
// 'State<AiInputScreen>' is the type of state that this widget will manage.
// 'createState()' creates the mutable state for this widget, which is defined in the _AiInputScreenState class.
  @override
  State<AiInputScreen> createState() => _AiInputScreenState();
}


// Part 3: _AiInputScreenState Class
// This is the state class for AiInputScreen.
// It holds the mutable state of the widget, including user input, AI result, and loading status.
class _AiInputScreenState extends State<AiInputScreen> {
  // This is the controller for the TextField to get user input
  final TextEditingController _textController = TextEditingController();

  // Here I instantiate the AI service to send user input and receive AI responses.
  final AiService _aiService = AiService();

  // This is a string '_aiResult' that holds the AI response text with a placeholder message.
  String _aiResult = 'Enter text and press "Process AI"';

  // This line tracks whether the AI request is currently processing.
  bool _isLoading = false;


  // Part 4: Widget Lifecycle Methods
  // Dispose method is called when the widget is removed from the widget tree
  // This is where we clean up controllers to avoid memory leaks
  // 'void' means this method does not return any value.
  // 'dispose()' is called when the widget is removed from the widget tree.
  // '_textController.dispose()' cleans up the TextEditingController to free resources.
  // 'super.dispose()' calls the parent class's dispose method to ensure proper cleanup.
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }


  // Part 5: Helper Method to Show SnackBars (Temporary Messages)
  // Shows temporary messages at the bottom of the screen to inform the user
  void _showSnackBar(String message) {
    // 'ScaffoldMessenger.of(context)' gets the current ScaffoldMessenger for showing SnackBars.
    // 'showSnackBar' displays a SnackBar with the provided message.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }


  // Part 6: AI Processing Method
  // This method sends the user's input to the AI service and updates the UI with the result
  // 'Future<void>' means this method runs asynchronously and does not return a value.
  // '_processAi' is the method that handles the AI processing logic.
  // 'async' allows the use of 'await' for asynchronous operations.
  Future<void> _processAi() async {
    // If the input field is empty, this line shows an error message and returns early.
    if (_textController.text.isEmpty) {
      _showSnackBar('Please enter some text to process.');
      return;
    }

    // This line sets loading state to true and shows a "Processing..." message.
    setState(() {
      _isLoading = true;
      _aiResult = 'Processing...';
    });

    try {
      // This line calls the AI service and awaits the response.
      final result = await _aiService.processTextWithAI(_textController.text);

      // Then I update the UI with the AI result.
      setState(() {
        _aiResult = result;
      });

      // Inform the user that processing is complete.
      _showSnackBar('AI processing complete!');
    } catch (e) {
      // Handle errors by showing the error message (if any) and updating the UI.
      setState(() {
        _aiResult = 'Error: $e';
      });
      // This line shows an error message in a SnackBar.
      _showSnackBar('Failed to process AI: $e');
    } finally {
      // Reset loading state regardless of success or failure.
      setState(() {
        _isLoading = false;
      });
    }
  }


  // Part 7: Build Method
  // This method builds the visual layout of the screen.
  // It returns a Scaffold widget, which provides the basic visual structure of a Material Design page.
  // 'build' is called when the widget is created or updated.
  // 'Scaffold' is a widget that provides the basic structure for the screen, including an AppBar, body, and other visual elements.
  // 'appBar' is the top bar of the screen, which contains the title.
  // 'title' is the text displayed in the AppBar.
  // 'backgroundColor' sets the color of the AppBar to match the theme.'
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartRep AI Input'),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      // Body of the screen with padding
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center widgets vertically
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch widgets horizontally
          children: [
            // Input field for user text
            TextField(
              controller: _textController, // Connects TextField to controller
              decoration: const InputDecoration(
                labelText: 'Enter text for AI', // Placeholder text
                border: OutlineInputBorder(), // Material Design border
                prefixIcon: Icon(Icons.lightbulb_outline), // Icon inside TextField
              ),
              maxLines: 3, // Allow multi-line input
            ),

            const SizedBox(height: 20), // Space between input and button

            // Display loading indicator or AI processing button
            _isLoading
                ? const Center(child: CircularProgressIndicator()) // Show spinner if loading
                : ElevatedButton(
                    onPressed: _processAi, // Call _processAi when pressed
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16), // Button height
                      textStyle: const TextStyle(fontSize: 18), // Button text size
                    ),
                    child: const Text('Process with AI'), // Button label
                  ),

            const SizedBox(height: 30), // Space before AI result display

            // Label for AI result section
            const Text(
              'AI Result:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10), // Space between label and result

            // Scrollable area to show AI result
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _aiResult, // Display the AI result text
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}