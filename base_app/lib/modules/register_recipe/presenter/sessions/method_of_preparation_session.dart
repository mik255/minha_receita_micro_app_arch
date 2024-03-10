import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';

import '../components/actions_add_remove.dart';
import '../components/add_button.dart';
import '../components/carousel.dart';
import '../components/ds_chip.dart';
import '../components/ds_session.dart';
import '../components/row_icons_menu.dart';
import '../controller/method_of_preparation_controller.dart';

class MethodOfPreparationSession extends StatefulWidget {
  const MethodOfPreparationSession({super.key});

  @override
  State<MethodOfPreparationSession> createState() =>
      _MethodOfPreparationSessionState();
}

class _MethodOfPreparationSessionState
    extends State<MethodOfPreparationSession> {
  final MethodOfPreparationCubit _methodOfPreparationCubit =
      MethodOfPreparationCubit();

  @override
  void initState() {
    super.initState();
    // _methodOfPreparationCubit.setMethodOfPreparation();
  }

  GlobalKey globalKey = GlobalKey();
  final height = ValueNotifier(300.0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _methodOfPreparationCubit,
        builder: (context, state) {
          return AnimatedBuilder(
              animation: height,
              builder: (context, _) {
                return DSSession(
                  physics: const NeverScrollableScrollPhysics(),
                  icon: Icons.paste_sharp,
                  title: 'Modo de preparo',
                  subtitle: 'Adicione o modo de preparo da sua receita',
                  height: () {
                    if (state == null ||
                        state is MethodOfPreparationInitialState) {
                      return 300.0;
                    }
                    state as MethodOfPreparationSuccessState;
                    if (state.methodOfPreparation.isEmpty) {
                      return 300.0;
                    }
                    if (globalKey.currentContext == null) {
                      return state.methodOfPreparation.length * 300.0;
                    }
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      height.value = globalKey.currentContext!.size!.height;
                    });
                    return height.value;
                  }(),
                  content: Padding(
                    key: globalKey,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Column(
                          children: List.generate(() {
                            if (state == null ||
                                state is MethodOfPreparationInitialState) {
                              return 0;
                            }
                            state as MethodOfPreparationSuccessState;
                            if (state.methodOfPreparation.isEmpty) {
                              return 0;
                            }
                            return state.methodOfPreparation.length;
                          }(),
                              (index) => Column(
                                children: [
                                  Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    () {
                                                      if (state == null ||
                                                          state
                                                              is MethodOfPreparationInitialState) {
                                                        return '1.';
                                                      }
                                                      state
                                                          as MethodOfPreparationSuccessState;

                                                      return '${state.methodOfPreparation[index].methodOfPreparation.step}.';
                                                    }(),
                                                    style: const TextStyle(
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
                                                      maxLines: 5,
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(
                                                                0.949999988079071),
                                                        fontSize: 13,
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ).convertToInput(
                                                      hintText:
                                                          'Adicione um ingrediente',
                                                      focusNode: FocusNode(),
                                                      controller: () {
                                                        if (state == null ||
                                                            state
                                                                is MethodOfPreparationInitialState) {
                                                          return TextEditingController();
                                                        }
                                                        state
                                                            as MethodOfPreparationSuccessState;
                                                        return state
                                                            .methodOfPreparation[
                                                                index]
                                                            .controller;
                                                      }(),
                                                      onValidate: (String? a) {
                                                        _methodOfPreparationCubit
                                                            .setDescMethodOfPreparation(
                                                                index, a ?? '');
                                                        return null;
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              selectOptions(index);
                                            },
                                            child: const RowIconsMenu(),
                                          ),
                                        ],
                                      ),
                                      () {
                                    if (state == null ||
                                        state
                                        is MethodOfPreparationInitialState) {
                                      return const SizedBox();
                                    }
                                    state
                                    as MethodOfPreparationSuccessState;
                                    if (state.methodOfPreparation[index]
                                        .imgBase64.isEmpty) {
                                      return const SizedBox();
                                    }
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                            vertical: 16.0),
                                        child: DSCarousel(
                                          pageController: PageController(
                                            initialPage: 0,
                                          ),
                                          base64ImgList: () {
                                            if (state
                                            is MethodOfPreparationInitialState) {
                                              return <String>[];
                                            }
                                            state;
                                            return state
                                                .methodOfPreparation[index]
                                                .imgBase64;
                                          }(),
                                          recipeImgUrlList: [],
                                        ));
                                  }(),
                                ],
                              )),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 16.0),
                                child: DSChip(
                                  onTap: () {
                                    _methodOfPreparationCubit
                                        .setMethodOfPreparation();
                                  },
                                  title: 'Adicionar',
                                  backgroundColor: const Color(0xFFFFF1DF),
                                  titleColor: const Color(0xFFFF9811),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  void selectOptions(int index) {
    context.commonExtensionsShowDSModal(
        customContent: DSModal(
            dsModalVariants: DSModalVariants.optionsModal,
            title: 'Modo de preparo',
            subtitle: 'Adicione uma ação',
            buttons: [
          DSCustomButton(
            type: DSCustomButtonTypes.outline,
            padding: const EdgeInsets.symmetric(vertical: 8),
            text: 'Adicionar foto',
            onTap: () {
              _methodOfPreparationCubit.setPhotoMethodOfPreparation(index);
              Navigator.pop(context);
              setState(() {});
            },
          ),
          DSCustomButton(
            type: DSCustomButtonTypes.outline,
            padding: const EdgeInsets.symmetric(vertical: 8),
            text: 'remover foto',
            onTap: () {
              _methodOfPreparationCubit.photoRemoveMethodOfPreparation(index);
              Navigator.pop(context);
              setState(() {});
            },
          ),
          DSCustomButton(
            type: DSCustomButtonTypes.outline,
            padding: const EdgeInsets.symmetric(vertical: 8),
            text: 'remover passo',
            onTap: () {
              _methodOfPreparationCubit.removeMethodOfPreparation(index);
              Navigator.pop(context);
              setState(() {});
            },
          )
        ]));
  }
}
