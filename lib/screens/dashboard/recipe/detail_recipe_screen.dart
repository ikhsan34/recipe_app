import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/dashboard/recipe/components/action_buttons.dart';
import 'package:recipe_app/screens/dashboard/recipe/components/ingredients_table.dart';
import 'package:recipe_app/screens/dashboard/recipe/services/recipe_provider.dart';
import 'package:recipe_app/shared/loadings.dart';

class DetailRecipeScreen extends StatefulWidget {
  final RecipeModel recipe;
  final bool isSearching;
  const DetailRecipeScreen({Key? key, required this.recipe, required this.isSearching}) : super(key: key);

  @override
  State<DetailRecipeScreen> createState() => _DetailRecipeScreenState();
}

class _DetailRecipeScreenState extends State<DetailRecipeScreen> {
  bool isNavigate = false;

  @override
  Widget build(BuildContext context){

    final APIState state = Provider.of<RecipeProvider>(context).apiState;
    final List<RecipeModel> savedRecipes = Provider.of<RecipeProvider>(context).savedRecipes;

    bool isSaved() {
      for(var item in savedRecipes) {
        if (item.recipeId == widget.recipe.recipeId) {
          return true;
        }
      }
      return false;
    }
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.recipe.name),
              background: Hero(
                tag: '${widget.recipe.recipeId} + ${widget.isSearching}',
                child: CachedNetworkImage(
                  imageUrl: widget.recipe.imgUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  color: Colors.grey,
                  colorBlendMode: BlendMode.modulate,
                  placeholder: (context, url) => SpinKitCubeGrid(color: Theme.of(context).colorScheme.primary),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Recipe By: '),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(widget.recipe.recipeSource),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Calories: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black
                        ),
                        children: [
                          TextSpan(
                            text: widget.recipe.calories.round().toString(),
                            style: const TextStyle(
                            fontWeight: FontWeight.bold
                            ),
                          ),
                          const TextSpan(text: ' cal')
                        ]
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Ingredients
                  Text(
                    '${widget.recipe.ingredients.length} Ingredients',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const Divider(),
                  IngredientsTable(ingredients: widget.recipe.ingredients),
                  const SizedBox(height: 20),

                  // Preparation
                  const Text(
                    'Preparations',
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Click Here for Instructions'),
                      const SizedBox(width: 10),
                      isNavigate
                      ? Loadings.simpleCircleLoading(context)
                      : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isNavigate = true;
                          });
                          await Navigator.pushNamed(
                            context,
                            '/instruction_screen',
                            arguments: widget.recipe.sourceUrl
                          ).then((_) {
                            setState(() {
                              isNavigate = false;
                            });
                          });
                          
                        },
                        child: const Text('Instructions'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Actions
                  const Text(
                    'Actions',
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  
                  const Divider(),
                  SizedBox(
                    width: double.infinity,
                    child: state == APIState.loading
                    ? Loadings.simpleCircleLoading(context)
                    : widget.isSearching == false
                    ? deleteRecipeButton(context: context, recipe: widget.recipe)
                    : isSaved()
                    ? const Text('This recipe is already saved')
                    : saveRecipeButton(context: context, recipe: widget.recipe)
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}