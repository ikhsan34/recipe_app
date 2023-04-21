import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_app/models/recipe_model.dart';

class RecipeApi {

  static Future<List<RecipeModel>?> searchRecipes(String keyword) async {

    const String type = 'public';
    const String appId = '42aef1d6';
    const String appKey = '9bb435825060bae9c2590fa09144134a';

    final Uri url = Uri.parse('https://api.edamam.com/api/recipes/v2?type=$type&app_id=$appId&app_key=$appKey&q=$keyword');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)['hits'];
        final List<RecipeModel> recipes = result.map((item) {
          final json = jsonEncode(item['recipe']);
          return RecipeModel.fromJson(json: json);
        }).toList();
        // print(result[0]['recipe']);
        return recipes;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

}