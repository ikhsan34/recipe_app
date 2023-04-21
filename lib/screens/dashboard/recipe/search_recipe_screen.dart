import 'package:flutter/material.dart';
import 'package:recipe_app/models/api/recipe_api.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/screens/dashboard/recipe/recipe_provider.dart';

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({super.key});

  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<RecipeProvider>(context).recipes;
    print(recipes);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                filled: true,
                labelText: 'Search',
                border: InputBorder.none
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<RecipeProvider>(context, listen: false).searchRecipe();
              },
              child: const Text('Search'),
            ),
            const Divider(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Title'),
                  subtitle: Text('Subtitle'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}