import 'package:flutter/material.dart';
import 'package:micro_app_common/micro_app_common.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
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
                    child: DSLogo().get(),
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


