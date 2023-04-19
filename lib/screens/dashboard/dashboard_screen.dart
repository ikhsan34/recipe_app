import 'package:flutter/material.dart';
import 'package:recipe_app/screens/dashboard/search_recipe_screen.dart';
import 'package:recipe_app/screens/dashboard/recipe_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int currentIndex = 0;
  final List screens = [
    const RecipeScreen(),
    const SearchRecipeScreen()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.pushNamed(context, '/profile');
              }
              if (value == 'logout') {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.grey[600]),
                      const SizedBox(width: 5),
                      const Text('Profile')
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.grey[600]),
                      const SizedBox(width: 5),
                      const Text('Logout')
                    ],
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: screens[currentIndex],
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