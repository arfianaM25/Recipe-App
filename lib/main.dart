import 'package:flutter/material.dart';
import 'package:flutter_application/screen/recipe_list_screen.dart' as recipeList;
import 'package:flutter_application/screen/welcome_screen.dart' as welcome;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => welcome.WelcomeScreen(),
        '/recipeList': (context) => recipeList.RecipeSelectionScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}