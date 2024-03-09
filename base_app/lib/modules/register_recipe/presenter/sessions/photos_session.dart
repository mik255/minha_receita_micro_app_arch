import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import '../components/actions_add_remove.dart';
import '../components/add_button.dart';
import '../components/add_photo.dart';
import '../components/carousel.dart';
import '../components/ds_session.dart';
import '../controller/photo_controller.dart';

class PhotoSession extends StatefulWidget {
  const PhotoSession({super.key});

  @override
  State<PhotoSession> createState() => _PhotoSessionState();
}

class _PhotoSessionState extends State<PhotoSession> {
  final PhotoCubit _photoCubit = PhotoCubit();
  final isOpen = ValueNotifier(false);
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _photoCubit,
        builder: (context, state) {
          return DSSession(
            icon: Icons.photo_camera_outlined,
            title: 'Fotos',
            subtitle: 'Adicione fotos a sua receita já finalizada',
            isOpen: isOpen,
            content: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(builder: (context) {
                return Column(
                  children: [
                    ActionsAddRemove(
                      onAdd: () async {
                        await _photoCubit.addPhoto();
                        isOpen.value = true;
                        // isOpen.value = false;
                        // await Future.delayed(const Duration(milliseconds: 500));
                        // isOpen.value = true;
                      },
                      onRemove: () {
                        if (pageController.page?.toInt() != null) {
                          return;
                        }
                        // _photoCubit.removePhoto(pageController.page!.toInt());
                      },
                    ),
                    if (_photoCubit.files.isNotEmpty)
                      Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          DSCarousel(
                            pageController: pageController,
                            base64ImgList: _photoCubit.files,
                            recipeImgUrlList: const [],
                            widgets: const [],
                            onTap: (i) {},
                          ),
                        ],
                      ),
                  ],
                );
              }),
            ),
          );
        });
  }
}
