// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/dashboard/recipe/services/recipe_provider.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text), duration: const Duration(seconds: 3),));
}

Widget saveRecipeButton({required BuildContext context, required RecipeModel recipe}) => ElevatedButton(
  style: ButtonStyle(
    fixedSize: MaterialStateProperty.all(const Size.fromHeight(20))
  ),
  onPressed: () async {
    final bool result = await Provider.of<RecipeProvider>(context, listen: false).saveRecipe(recipe);
    if (result == true) {
      snackBar(context, 'Recipe saved successfully');
    } else {
      snackBar(context, 'Save failed, please try again');
    }
  },
  child: const Text('Save Recipe'),
);

Widget deleteRecipeButton({required BuildContext context, required RecipeModel recipe}) => ElevatedButton(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.red[400]),
    fixedSize: MaterialStateProperty.all(const Size.fromHeight(20))
  ),
  onPressed: () async {
    final bool result = await Provider.of<RecipeProvider>(context, listen: false).deleteRecipe(recipe);
    if (result == true) {
      snackBar(context, 'Recipe deleted successfully');
      Navigator.pop(context);
    } else {
      snackBar(context, 'Delete failed, please try again');
    }
  },
  child: const Text('Delete Recipe'),
);