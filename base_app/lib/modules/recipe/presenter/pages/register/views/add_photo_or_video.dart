import 'package:flutter/material.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import '../recipe_register_page.dart';

class AddPhotoOrVideo extends StatelessWidget implements PageData {
  const AddPhotoOrVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children:  [
          ],
        ));
  }

  @override
  String get description => 'Adicione uma foto ou vídeo da sua receita';

  @override
  IconData get icon => Icons.photo_camera_outlined;

  @override
  String get title => 'Adicionar foto ou vídeo';

  @override
  Widget get buttons => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32),
    child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DSCustomButton(
              padding: EdgeInsets.zero,
              text: 'Adicionar',
              onTap: () {},
              type: DSCustomButtonTypes.solid,
            ),
            const SizedBox(
              height: 16,
            ),
            DSCustomButton(
              padding: EdgeInsets.zero,
              text: 'Próximo',
              onTap: () {},
              type: DSCustomButtonTypes.outline,
            ),
          ],
        ),
  );
}
