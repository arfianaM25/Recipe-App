import 'package:flutter/material.dart';
import 'package:flutter_application/screen/burgeringredients.dart';
import 'package:flutter_application/screen/sushiingredients.dart';

class RecipeSelectionScreen extends StatefulWidget {
  @override
  _RecipeSelectionScreenState createState() => _RecipeSelectionScreenState();
}

class _RecipeSelectionScreenState extends State<RecipeSelectionScreen> {
  String selectedFilter = "All";
  int _selectedIndex = 0;

  // List of all recipes
  final List<Map<String, String>> recipes = [
    {
      "name": "Salmon Sushi Matcha",
      "image": "images/sushi.jpg", // Replace with your sushi image path
      "type": "Sushi",
      "details": "12 Ingredients | 40 Min"
    },
    {
      "name": "Classic Burger",
      "image": "images/burger.jpg", // Replace with your burger image path
      "type": "Burger",
      "details": "10 Ingredients | 30 Min"
    },
    // Add more recipes as needed
  ];

  // List to store bookmarked recipes
  List<Map<String, String>> bookmarkedRecipes = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to handle bookmarking a recipe
  void _toggleBookmark(Map<String, String> recipe) {
    setState(() {
      if (bookmarkedRecipes.contains(recipe)) {
        bookmarkedRecipes.remove(recipe);  // Remove from bookmarks
      } else {
        bookmarkedRecipes.add(recipe);  // Add to bookmarks
      }
    });
  }

  // Check if a recipe is bookmarked
  bool _isBookmarked(Map<String, String> recipe) {
    return bookmarkedRecipes.contains(recipe);
  }

  @override
  Widget build(BuildContext context) {
    // Filter recipes based on selection
    List<Map<String, String>> filteredRecipes = recipes.where((recipe) {
      return selectedFilter == "All" || recipe["type"] == selectedFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Find Best Recipe",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              "For Cooking",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and filter row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search Recipe",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.tune, color: Color(0xFF22C55E)),
                    onPressed: () {}, // Functionality for further filtering
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Filter Buttons
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFilterChip("All"),
                  SizedBox(width: 10),
                  _buildFilterChip("Sushi"),
                  SizedBox(width: 10),
                  _buildFilterChip("Burger"),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Display recipes or bookmarks based on selection
            Expanded(
              child: _selectedIndex == 1 // Check if the user selected "Bookmarks"
                  ? bookmarkedRecipes.isNotEmpty
                      ? ListView.builder(
                          itemCount: bookmarkedRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = bookmarkedRecipes[index];
                            return ListTile(
                              leading: Image.asset(recipe["image"]!),
                              title: Text(recipe["name"]!),
                              subtitle: Text(recipe["details"]!),
                              onTap: () {
                                if (recipe["type"] == "Sushi") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SushiIngredientsScreen(),
                                    ),
                                  );
                                } else if (recipe["type"] == "Burger") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BurgerIngredientsScreen(),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        )
                      : Center(child: Text("No Bookmarks"))
                  : filteredRecipes.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            if (filteredRecipes[0]["type"] == "Sushi") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SushiIngredientsScreen(),
                                ),
                              );
                            } else if (filteredRecipes[0]["type"] == "Burger") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BurgerIngredientsScreen(),
                                ),
                              );
                            }
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(filteredRecipes[0]["image"]!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                right: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filteredRecipes[0]["name"]!,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      filteredRecipes[0]["details"]!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 20,
                                right: 20,
                                child: IconButton(
                                  icon: Icon(
                                    _isBookmarked(filteredRecipes[0]) 
                                      ? Icons.bookmark 
                                      : Icons.bookmark_border,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _toggleBookmark(filteredRecipes[0]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(child: Text("No recipes available")),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildFilterChip(String filter) {
    return Expanded(
      child: ChoiceChip(
        label: Text(filter),
        selected: selectedFilter == filter,
        onSelected: (bool selected) {
          setState(() {
            selectedFilter = filter;
          });
        },
        selectedColor: Color(0xFF22C55E),
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
