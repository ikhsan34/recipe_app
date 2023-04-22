import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/dashboard/recipe/recipe_provider.dart';

class DetailRecipeScreen extends StatelessWidget {
  final int index;
  const DetailRecipeScreen({ Key? key, required this.index }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final RecipeModel recipe = Provider.of<RecipeProvider>(context).recipes[index];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipe.name, 
                style: TextStyle(
                  shadows: <Shadow>[
                    Shadow(
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.grey[300]!,
                    ),
                  ],
                ),
              ),
              background: CachedNetworkImage(
                imageUrl: recipe.imgUrl,
                width: double.infinity,
                fit: BoxFit.cover,
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
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const Divider(),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recipe.ingredients.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final Ingredients ingredients = recipe.ingredients[index];
                      return Text('${ingredients.text} + ${ingredients.quantity.toString()}');
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(recipe.name),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         ClipRRect(
    //           borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
    //           child: CachedNetworkImage(
    //             imageUrl: recipe.imgUrl,
    //             width: double.infinity,
    //             fit: BoxFit.cover,
    //             placeholder: (context, url) => SpinKitCubeGrid(color: Theme.of(context).colorScheme.primary),
    //             errorWidget: (context, url, error) => const Icon(Icons.error),
    //           ),
    //         ),
    //         const SizedBox(height: 20),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20),
    //           child: Text(
    //             recipe.name,
    //             style: const TextStyle(
    //               fontWeight: FontWeight.w500,
    //               letterSpacing: 1.5
    //             ),
    //           ),
    //         ),
    //         const Divider(),
    //       ],
    //     ),
    //   ),
    // );
  }
}