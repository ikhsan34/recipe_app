import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/screens/dashboard/recipe/search_recipe_screen.dart';
import 'package:recipe_app/screens/dashboard/recipe/recipe_screen.dart';
import 'package:recipe_app/screens/dashboard/recipe/services/recipe_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<RecipeProvider>(context, listen: false).getSavedRecipes();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const RecipeScreen(),
      const SearchRecipeScreen()
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            label: 'Search Recipe',
            icon: Icon(Icons.search)
          ),
        ],
      ),
    );
  }
}