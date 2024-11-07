import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/platter.jpeg'), // Replace with your image asset
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Dark overlay for better text visibility
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                Spacer(), // Pushes content to the bottom

                // Text and Button at the bottom
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text at the bottom
                      Text(
                        'Cooking Experience Like a Chef',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Let\'s make a delicious dish with the best recipe for the family',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 30),

                      // Get Started Button at the very bottom
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/recipeList');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF22C55E),
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Ensures the button takes only necessary space
                          mainAxisAlignment: MainAxisAlignment.center, // Center the content
                          children: [
                            // Circular background for the arrow
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white, // White background
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward, // Arrow icon
                                color: Color(0xFF22C55E), // Green color for the arrow
                              ),
                            ),
                            SizedBox(width: 8), // Space between icon and text
                            Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30), // Bottom padding
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
