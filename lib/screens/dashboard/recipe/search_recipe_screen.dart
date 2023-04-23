import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/dashboard/recipe/components/recipe_list_tile.dart';
import 'package:recipe_app/screens/dashboard/recipe/services/recipe_provider.dart';
import 'package:recipe_app/shared/loadings.dart';

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({super.key});

  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {

  final keywordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    keywordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<RecipeModel> recipes = Provider.of<RecipeProvider>(context).recipes;
    final APIState state = Provider.of<RecipeProvider>(context).apiState;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: keywordController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search),
                      filled: true,
                      labelText: 'Search',
                      border: InputBorder.none
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Provider.of<RecipeProvider>(context, listen: false).searchRecipe(keywordController.text.trim());
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            state == APIState.loading
            ? Loadings.fadingCircle()
            : recipes.isEmpty
            ? const Text('Search some recipes')
            : state == APIState.none
            ? RecipeListTile(recipes: recipes)
            : const Text('Failed to get data, make sure internet is available')
          ],
        ),
      ),
    );
  }
}