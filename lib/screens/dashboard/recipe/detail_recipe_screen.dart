import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/auth/auth_provider.dart';
import 'package:recipe_app/screens/dashboard/recipe/components/ingredients_table.dart';
import 'package:recipe_app/screens/dashboard/recipe/services/recipe_firestore.dart';
import 'package:recipe_app/screens/dashboard/recipe/services/recipe_provider.dart';

class DetailRecipeScreen extends StatelessWidget {
  final RecipeModel recipe;
  const DetailRecipeScreen({ Key? key, required this.recipe }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final User user = Provider.of<AuthProvider>(context).user!;
    final APIState state = Provider.of<RecipeProvider>(context).apiState;
    final List<RecipeModel> savedRecipes = Provider.of<RecipeProvider>(context).savedRecipes;

    bool isSaved() {
      if (savedRecipes.contains(recipe)) {
        return true;
      }
      return false;
    }

    void setAPIState(APIState state) {
      Provider.of<RecipeProvider>(context, listen: false).setAPIState(state);
    }
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(recipe.name),
              background: CachedNetworkImage(
                imageUrl: recipe.imgUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                color: Colors.grey,
                colorBlendMode: BlendMode.modulate,
                placeholder: (context, url) => SpinKitCubeGrid(color: Theme.of(context).colorScheme.primary),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                    child: Text(recipe.recipeSource),
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
                            text: recipe.calories.round().toString(),
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
                    '${recipe.ingredients.length} Ingredients',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const Divider(),
                  IngredientsTable(ingredients: recipe.ingredients),
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/instruction_screen',
                            arguments: recipe.sourceUrl
                          );
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
                    ? SpinKitCircle(
                      color: Theme.of(context).colorScheme.primary,
                    )
                    : isSaved()
                    ? const Text('This recipe is already saved')
                    : ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(const Size.fromHeight(20))
                      ),
                      onPressed: () async {
                        setAPIState(APIState.loading);
                        ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(String text) {
                          return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text), duration: const Duration(seconds: 3),));
                        }

                        final String result = await RecipeFirestore(uid: user.uid).addRecipe(recipe: recipe);
                        if (result == 'success') {
                          snackBar('Recipe saved successfully');
                        } else {
                          snackBar('Save failed, please try again');
                        }
                        setAPIState(APIState.none);
                      },
                      child: const Text('Save Recipe'),
                    ),
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