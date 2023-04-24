import 'dart:convert';

class RecipeModel {
  final String? docId;
  final String recipeId;
  final String name;
  final String imgUrl;
  final double calories;
  final List<Ingredients> ingredients;
  final String recipeSource;
  final String sourceUrl;

  RecipeModel({
    required this.docId,
    required this.recipeId, 
    required this.name, 
    required this.imgUrl, 
    required this.calories,
    required this.ingredients,
    required this.recipeSource,
    required this.sourceUrl
  });

  static RecipeModel fromJson({required json}) {
    final data = jsonDecode(json.toString());
    final List ingredients = data['ingredients'];
    return RecipeModel(
      docId: null,
      recipeId: data['uri'].toString().substring(43),
      name: data['label'],
      imgUrl: data['image'],
      calories: data['calories'],
      ingredients: ingredients.map((item) {
        return Ingredients(
          text: item['text'],
          quantity: item['quantity'],
          measure: item['measure'],
          food: item['food'],
          weight: item['weight'],
          foodCategory: item['foodCategory'],
          imgUrl: item['imgUrl']
        );
      }).toList(),
      recipeSource: data['source'],
      sourceUrl: data['url']
    );
  }
}

class Ingredients {
  final String? text;
  final double? quantity;
  final String? measure;
  final String? food;
  final double? weight;
  final String? foodCategory;
  final String? imgUrl;

  const Ingredients({
    required this.text,
    required this.quantity,
    required this.measure,
    required this.food,
    required this.weight,
    required this.foodCategory,
    required this.imgUrl
  });

}