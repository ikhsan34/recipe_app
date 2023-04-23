import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/dashboard/recipe/instruction_screen.dart';
import 'package:recipe_app/screens/dashboard/recipe/recipe_provider.dart';

class DetailRecipeScreen extends StatelessWidget {
  final int index;
  const DetailRecipeScreen({ Key? key, required this.index }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final RecipeModel recipe = Provider.of<RecipeProvider>(context).recipes[index];

    List<TableRow> ingredientsRow() {

      List<TableRow> list = [
        const TableRow(
          children: [
            Center(child: Text('No', style: TextStyle(fontWeight: FontWeight.w500))),
            Text('Ingredients', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Quantity', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Measure', style: TextStyle(fontWeight: FontWeight.w500))
          ]
        )
      ];
      int counter = 1;
      for(var ingredient in recipe.ingredients) {
        list.add(
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Center(child: Text(counter.toString())),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(ingredient.food!),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(ingredient.quantity.toString()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(ingredient.measure?? '-'),
              ),
            ]
          )
        );
        counter++;
      }
      return list;
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
                  Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(30),
                      1: FlexColumnWidth(2),
                    },
                    children: ingredientsRow()
                  ),
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