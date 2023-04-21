import 'package:flutter/material.dart';

class DetailRecipeScreen extends StatelessWidget {
  final String recipeName;
  const DetailRecipeScreen({ Key? key, required this.recipeName }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Icon(Icons.image),
            Text('Name')
          ],
        ),
      ),
    );
  }
}