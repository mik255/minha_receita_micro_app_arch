import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_receita/design_system/avatar/avatar.dart';
import 'package:minha_receita/design_system/cards/default_dialog.dart';
import 'package:minha_receita/design_system/page_view/page_view.dart';
import 'package:minha_receita/design_system/templates/base_page.dart';
import 'package:minha_receita/modules/common/navigator/navigator.dart';
import '../../../../design_system/appBars/app_bar.dart';
import '../../../../design_system/bottons/buttom.dart';
import '../../../../design_system/bottons/text_button.dart';
import '../../../../design_system/check_box/check_box.dart';
import '../../../../design_system/text_inputs/text_field.dart';
import '../states/register_states.dart';
import '../store/register_store.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  var codeController = TextEditingController();
  var pageController = PageController();
  var store = GetIt.I<RegisterStore>();

  @override
  Widget build(BuildContext context) {
    return AppDSBasePage(
      appDSAppBar: const AppDSAppBar(
        type: AppDSBarType.variant1,
        backgroundColor: Colors.transparent,
        onlyLeading: true,
        title: 'Cadastro',
        popLeading: true,
      ),
      body: ListenableBuilder(
          listenable: store,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const DSAvatar(
                  size: 100,
                  imgUrl:
                      'https://source.unsplash.com/random/80x600/?wallpaper',
                  nameStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  nameBelowAvatar: true,
                  namePadding: EdgeInsets.symmetric(vertical: 16),
                  name: 'mikael',
                ),
                Expanded(
                  child: DSPageView(pageController: pageController, children: [
                    _form(),
                    _codeVerification(),
                  ]),
                )
              ],
            );
          }),
    );
  }

  Widget _form() {
    return Padding(
      padding: const EdgeInsets.all(32.0).copyWith(top: 0),
      child: DSDefaultCardDialogContent(
        title: 'Cadastro',
        subtitle:
            'Bem vindo ao minha receita, estamos feliz por ter você aqui, cadastre-se para continuar',
        middleCustomContent: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              AppDSTextField(
                controller: nameController,
                onValidate: (value) {
                  store.setEmail(value ?? '');
                  return store.emailIsValid();
                },
                hintText: 'como podemos te chamar?',
              ),
              AppDSTextField(
                obscureText: true,
                controller: emailController,
                onValidate: (value) {
                  store.setPassword(value ?? '');
                  return store.passwordIsValid();
                },
                hintText: 'Email',
              ),
              AppDSTextField(
                controller: passwordController,
                onValidate: (value) {
                  store.setEmail(value ?? '');
                  return store.emailIsValid();
                },
                hintText: 'Senha',
              ),
              AppDSTextField(
                obscureText: true,
                controller: confirmPasswordController,
                onValidate: (value) {
                  store.setPassword(value ?? '');
                  return store.passwordIsValid();
                },
                hintText: 'Confirme sua senha',
              ),
            ],
          ),
        ),
        buttons: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DSCheckBox(
                description: 'Aceitar os termos de uso',
              ),
              DSTextButton(
                onPressed: () {
                  CommonNavigator.navigateTo(
                    '/account/register',
                  );
                },
                text: 'ler termos de uso',
              ),
              Row(
                children: [
                  Expanded(
                    child: DSCustomButton(
                        padding: EdgeInsets.zero,
                        text: 'Continuar',
                        isLoading: store.state is RegisterLoading,
                        // onTap: () {
                        //   if (store.buttonEnabled) {
                        //     return () => store.registerEvent();
                        //   }
                        // }()
                        onTap: () {
                          pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _codeVerification() {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0).copyWith(top: 0),
            child: DSDefaultCardDialogContent(
              title: 'Verificação de código',
              subtitle:
                  'Quase lá só falta confirmar seu email, enviamos um código para o email que você cadastrou, por favor insira o código abaixo',
              middleCustomContent: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppDSTextField(
                      controller: codeController,
                      onValidate: (value) {
                        store.setEmail(value ?? '');
                        return store.emailIsValid();
                      },
                      hintText: 'código de verificação',
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
                              text: 'Continuar',
                              isLoading: store.state is RegisterLoading,
                              onTap: () {
                                if (store.buttonEnabled) {
                                  return () => store.registerEvent();
                                }
                              }()),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
