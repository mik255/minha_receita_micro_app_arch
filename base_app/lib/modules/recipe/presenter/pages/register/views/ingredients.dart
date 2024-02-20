import 'package:flutter/material.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import '../../../components/about.dart';
import '../recipe_register_page.dart';

class IngredientsView extends StatelessWidget implements PageData {
  const IngredientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            About(
              theme: Theme.of(context),
            ),
          ],
        ));
  }

  @override
  Widget get buttons => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DSCustomButton(
          padding: EdgeInsets.zero,
          text: 'Continuar',
          onTap: () {},
          type: DSCustomButtonTypes.solid,
        ),
      ],
    ),
  );

  @override
  // TODO: implement description
  String get description => 'Adicione os ingredientes da sua receita';

  @override
  // TODO: implement icon
  IconData get icon => Icons.local_grocery_store;

  @override
  // TODO: implement title
  String get title => 'Adicionar ingredientes';
}