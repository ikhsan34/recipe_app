import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/dashboard/recipe/recipe_provider.dart';
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
    final List recipes = Provider.of<RecipeProvider>(context).recipes;
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
            ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final RecipeModel recipe = recipes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context, 
                      '/detail_recipe',
                      arguments: index
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: recipe.imgUrl,
                              height: 50,
                              placeholder: (context, url) => SpinKitCubeGrid(color: Theme.of(context).colorScheme.primary),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.name, 
                                style: const TextStyle(
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text('Recipe by: '),
                                  Text(
                                    recipe.recipeSource,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic 
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
            : const Text('Failed to get data, make sure internet is available')
          ],
        ),
      ),
    );
  }
}