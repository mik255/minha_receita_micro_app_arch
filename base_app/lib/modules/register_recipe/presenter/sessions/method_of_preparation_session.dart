import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/add_button.dart';
import '../components/carousel.dart';
import '../components/ds_session.dart';

class MethodOfPreparationSession extends StatelessWidget {
  const MethodOfPreparationSession({super.key});

  @override
  Widget build(BuildContext context) {
    return DSSession(
      icon: Icons.paste_sharp,
      title: 'Modo de preparo',
      subtitle: 'Adicione o modo de preparo da sua receita',
      action: InkWell(
        onTap: () async {
          // final file = await CameraService().getMultiImages();
          // files.addAll(file);
          // setState(() {});
        },
        child: const AddCard(),
      ),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(
              5,
              (index) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const Text(
                              '1.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Text(
                                'Boa Maria, ótima receita! Sempre com excelentes dicas, show!',
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.949999988079071),
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: DSCarousel(
                            pageController: PageController(
                              initialPage: 0,
                            ),
                            recipeImgUrlList: const [
                              "https://source.unsplash.com/random/800x600/?food",
                              "https://source.unsplash.com/random/800x600/?food",
                              "https://source.unsplash.com/random/800x600/?food",
                              "https://source.unsplash.com/random/800x600/?food",
                            ],
                          ))
                    ],
                  )),
        ),
      ),
    );
  }
}
