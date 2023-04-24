import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/dashboard/recipe/components/recipe_list_tile.dart';
import 'package:recipe_app/screens/dashboard/recipe/services/recipe_provider.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<RecipeProvider>(context, listen: false).getSavedRecipes();
  });
  }

  @override
  Widget build(BuildContext context) {

    final List<RecipeModel> savedRecipes = Provider.of<RecipeProvider>(context).savedRecipes;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Recipes',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 10),
            RecipeListTile(recipes: savedRecipes)
          ]
        ),
      ),
    );
  }
}