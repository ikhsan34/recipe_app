import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:recipe_app/arguments/detail_recipe_screen_arguments.dart';
import 'package:recipe_app/models/recipe_model.dart';

class RecipeListTile extends StatelessWidget {
  
  final List<RecipeModel> recipes;
  final bool isSearching;
  const RecipeListTile({super.key, required this.recipes, this.isSearching = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
              arguments: DetailRecipeScreenArguments(recipe: recipe, isSearching: isSearching)
            );
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Text('Recipe by: '),
                            Expanded(
                              child: Text(
                                recipe.recipeSource,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic 
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}