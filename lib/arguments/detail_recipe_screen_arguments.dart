import 'package:recipe_app/models/recipe_model.dart';

class DetailRecipeScreenArguments {
  final RecipeModel recipe;
  final bool isSearching;

  const DetailRecipeScreenArguments({required this.recipe, required this.isSearching});
  
}