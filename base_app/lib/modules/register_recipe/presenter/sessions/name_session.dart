import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:minha_receita/modules/register_recipe/presenter/controller/name_description_controller.dart';

import '../components/ds_session.dart';

class NameAndDescriptionSession extends StatefulWidget {
  NameAndDescriptionSession({super.key});

  @override
  State<NameAndDescriptionSession> createState() =>
      _NameAndDescriptionSessionState();
}

class _NameAndDescriptionSessionState extends State<NameAndDescriptionSession>
    with AutomaticKeepAliveClientMixin {
  ValueNotifier<String> name = ValueNotifier<String>('Nome da receita');

  ValueNotifier<String> description = ValueNotifier<String>('Descrição');

  TextEditingController nameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  final NameDescriptionController _nameDescriptionController =
      NameDescriptionController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DSSession(
      icon: Icons.mode_edit_outline_outlined,
      title: name.value,
      subtitle: description.value,
      customTitle: AnimatedBuilder(
        animation: name,
        builder: (context,state) {
          return Text(
            name.value,
            style: theme.textTheme.titleLarge,
          );
        }
      ),
      customSubtitle: AnimatedBuilder(
          animation: description,
          builder: (context,state) {
            return Text(
              description.value,
              style: theme.textTheme.bodyMedium,
            );
          }
      ),
      content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AppDSTextField(
                labelText: 'Nome da receita',
                hintText: 'Ex: Bolo de cenoura',
                controller: nameController,
                onChange: (value) {
                  name.value = value;
                  _nameDescriptionController.setName(name.value);
                },
              ),
              const SizedBox(height: 16),
              AppDSTextField(
                labelText: 'Descrição',
                hintText: 'Ex: Bolo de cenoura com cobertura de chocolate',
                controller: descriptionController,
                maxLines: 5,
                onChange: (value) {
                  description.value = value;
                  _nameDescriptionController.setDescription(description.value);
                },
              ),
            ],
          )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
