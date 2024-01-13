import 'package:flutter/material.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';

class PageData {
  const PageData({
    required this.title,
    required this.description,
    required this.icon,
    required this.widget,
  });

  final String title;
  final String description;
  final IconData icon;
  final Widget widget;
}

class RegisterRecipePage extends StatefulWidget {
  const RegisterRecipePage({super.key});

  @override
  State<RegisterRecipePage> createState() => _RegisterRecipePageState();
}

class _RegisterRecipePageState extends State<RegisterRecipePage> {
  List<PageData> pagesData = [
    PageData(
      title: 'Adicione uma Foto ou video',
      description: 'Explique com mais detalhes como a sua receita funciona',
      icon: Icons.receipt_long_outlined,
      widget:                   Padding(
        padding: const EdgeInsets.all(32.0),
        child: DSDefaultCardDialogContent(
          middleCustomContent: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: const [
                SizedBox(
                  height: 200,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          buttons: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DSCustomButton(
                          padding: EdgeInsets.zero,
                          text: 'Entrar',
                          isLoading: false,
                          onTap: () {
                          }()),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      )
    ),
    PageData(
      title: 'Ingredientes',
      description: 'Adicione os ingredientes da sua receita',
      icon: Icons.receipt_long_outlined,
      widget: Container(
        color: Colors.amber,
      ),
    ),
    PageData(
      title: 'Modo de preparo',
      description: 'Adicione o modo de preparo da sua receita',
      icon: Icons.receipt_long_outlined,
      widget: Container(
        color: Colors.amber,
      ),
    ),];

  @override
  Widget build(BuildContext context) {
    return AppDSBasePage(
        body: Container(
      color: Theme.of(context).colorScheme.background,
      child: DSPageView(
        pageController: PageController(),
        children: [
          ...pagesData.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 48)
                    .copyWith(bottom: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: DSCustomContainer(
                        backgroundColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        width: 100,
                        height: 100,
                        iconPadding: const EdgeInsets.all(8),
                        iconColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        child: const Center(
                          child: Icon(
                            Icons.photo_camera_outlined,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      e.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      e.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    e.widget
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}
