import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/models/recipe_model.dart';

class RecipeFirestore {

  final String uid;
  final FirebaseFirestore firestore;
  final CollectionReference recipeCollection;
  RecipeFirestore({required this.firestore, required this.uid}) : recipeCollection = firestore.collection('users');


  // final CollectionReference recipeCollection = FirebaseFirestore.instance.collection('users');

  Future<String> addRecipe({required RecipeModel recipe}) async {

    List<Map> ingredientsToMap = recipe.ingredients.map((item) {
      return {
        'text': item.text,
        'quantity': item.quantity,
        'measure': item.measure,
        'food': item.food,
        'weight': item.weight,
        'foodCategory': item.foodCategory,
        'imgUrl': item.imgUrl
       };
    }).toList();

    Map<String, dynamic> recipeToMap = {
      'recipeId': recipe.recipeId,
      'name': recipe.name,
      'imgUrl': recipe.imgUrl,
      'calories': recipe.calories,
      'ingredients': ingredientsToMap,
      'recipeSource': recipe.recipeSource,
      'sourceUrl': recipe.sourceUrl
    };

    try {
      await recipeCollection.doc(uid).collection('recipes').add(recipeToMap);
      return 'success';
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  Future<String> deleteRecipe({required String docId}) async {
    try {
      await recipeCollection.doc(uid).collection('recipes').doc(docId).delete();
      return 'success';
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  List<RecipeModel> recipeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document){
      final Map recipe = document.data() as Map;
      final List ingredients = recipe['ingredients'];
      return RecipeModel(
        docId: document.id,
        recipeId: recipe['recipeId'], 
        name: recipe['name'], 
        imgUrl: recipe['imgUrl'], 
        calories: recipe['calories'], 
        ingredients: ingredients.map((ingredients) {
          return Ingredients(
            text: ingredients['text'], 
            quantity: ingredients['quantity'],
            measure: ingredients['measure'], 
            food: ingredients['food'], 
            weight: ingredients['weight'], 
            foodCategory: ingredients['food'], 
            imgUrl: ingredients['imgUrl']
          );
        }).toList(), 
        recipeSource: recipe['recipeSource'], 
        sourceUrl: recipe['sourceUrl']
      );
    }).toList();
  }

  // Stream Data
  Stream<List<RecipeModel>> get recipes => recipeCollection.doc(uid).collection('recipes').snapshots().map(recipeListFromSnapshot);

  // Get one time Data
  Future<List<RecipeModel>> get savedRecipes => recipeCollection.doc(uid).collection('recipes').get().then(recipeListFromSnapshot);

}