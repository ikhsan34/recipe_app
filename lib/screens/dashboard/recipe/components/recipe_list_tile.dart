import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:recipe_app/arguments/detail_recipe_screen_arguments.dart';
import 'package:recipe_app/models/recipe_model.dart';

class RecipeListTile extends StatefulWidget {
  
  final List<RecipeModel> recipes;
  final bool isSearching;
  const RecipeListTile({super.key, required this.recipes, this.isSearching = false});

  @override
  State<RecipeListTile> createState() => _RecipeListTileState();
}

class _RecipeListTileState extends State<RecipeListTile> {

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<RecipeModel> listRecipe = [];

  void addRecipe() async {
    for (var element in widget.recipes) {
      listRecipe.add(element);
      listKey.currentState!.insertItem(listRecipe.length - 1, duration: const Duration(milliseconds: 300));
      await Future.delayed(const Duration(milliseconds: 100), () {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addRecipe();
    });
  }

  final offset = Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).chain(CurveTween(curve: Curves.easeInOut));

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: listKey,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      initialItemCount: listRecipe.length,
      itemBuilder: (context, index, animation) {
        final RecipeModel recipe = listRecipe[index];
        return SlideTransition(
          position: animation.drive(offset),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context, 
                '/detail_recipe',
                arguments: DetailRecipeScreenArguments(recipe: recipe, isSearching: widget.isSearching)
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: '${recipe.recipeId} + ${widget.isSearching}',
                        child: CachedNetworkImage(
                          imageUrl: recipe.imgUrl,
                          height: 50,
                          placeholder: (context, url) => SpinKitCubeGrid(color: Theme.of(context).colorScheme.primary),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
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
          ),
        );
      },
    );
  }
}