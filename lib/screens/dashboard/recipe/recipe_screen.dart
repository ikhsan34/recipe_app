import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/dashboard/recipe/components/recipe_list_tile.dart';
import 'package:recipe_app/screens/dashboard/recipe/recipe_provider.dart';
import 'package:recipe_app/shared/loadings.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final APIState state = Provider.of<RecipeProvider>(context).apiState;
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
            state == APIState.loading
            ? Loadings.fadingCircle()
            : savedRecipes.isEmpty
            ? const Text('You haven\'t saved any recipe yet, try search some.')
            : RecipeListTile(recipes: savedRecipes)
          ]
        ),
      ),
    );
  }
}