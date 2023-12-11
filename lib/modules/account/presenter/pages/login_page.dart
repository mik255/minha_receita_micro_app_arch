import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_receita/design_system/cards/default_dialog.dart';
import 'package:minha_receita/design_system/templates/base_page.dart';
import 'package:minha_receita/modules/common/navigator/navigator.dart';
import '../../../../design_system/bottons/buttom.dart';
import '../../../../design_system/bottons/text_button.dart';
import '../../../../design_system/check_box/check_box.dart';
import '../../../../design_system/text_inputs/text_field.dart';
import '../states/login_states.dart';
import '../store/login_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var store = GetIt.I<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return AppDSBasePage(
      withScroll: true,
      body: ListenableBuilder(
          listenable: store,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80),
                    child: Image.asset('lib/design_system/assets/logo.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: DSDefaultCardDialogContent(
                      title: 'Login',
                      subtitle:
                          'Bem vindo ao minha receita, estamos feliz por ter você aqui,',
                      middleCustomContent: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          children: [
                            AppDSTextField(
                              controller: emailController,
                              onValidate: (value) {
                                store.setEmail(value ?? '');
                                return store.emailIsValid();
                              },
                              hintText: 'Email',
                            ),
                            AppDSTextField(
                              obscureText: true,
                              controller: passwordController,
                              onValidate: (value) {
                                store.setPassword(value ?? '');
                                return store.passwordIsValid();
                              },
                              hintText: 'Senha',
                            ),
                            const DSCheckBox(
                              description: 'Lembrar de mim',
                            ),
                          ],
                        ),
                      ),
                      buttons: [
                        Column(
                          children: [
                            DSTextButton(
                              onPressed: () {
                                CommonNavigator.navigateTo(
                                  '/account/register',
                                );
                              },
                              text: 'Cadastre-se',
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: DSCustomButton(
                                      padding: EdgeInsets.zero,
                                      text: 'Entrar',
                                      isLoading: store.state is LoginLoading,
                                      onTap: () {
                                        if (store.buttonEnabled) {
                                          return () => store.loginEvent();
                                        }
                                      }()),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}


