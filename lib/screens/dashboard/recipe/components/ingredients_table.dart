import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe_model.dart';

class IngredientsTable extends StatelessWidget {
  final List<Ingredients> ingredients;
  const IngredientsTable({super.key, required this.ingredients});

  List<TableRow> ingredientsRow(BuildContext context) {
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
      for(var ingredient in ingredients) {
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

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(30),
        1: FlexColumnWidth(2),
      },
      children: ingredientsRow(context)
    );
  }
}