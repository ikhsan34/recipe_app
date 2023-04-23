import 'package:flutter/material.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Recipes',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.image),
                    title: Text('Recipe Title $index'),
                    subtitle: const Text('Subtitle'),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail_recipe',
                        arguments: 'Recipe Title $index'
                      );
                    },
                  );
                },
              )
            ]
          ),
        ),
      ),
    );
  }
}