import 'package:minha_receita/modules/account/domain/models/account.dart';

import '../../../../core/http/core_http.dart';
import '../../domain/models/credentials.dart';
import '../exeptions/account_exeptions.dart';

abstract class AccountDataSource {
  Future<Account> login(Credentials credentials);

  Future<Account> register(Credentials credentials);

  Future<bool> registerCodeVerification(String code);

  Future<bool> sendConfirmRegisterCode();
}

class LoginDataSourceImpl implements AccountDataSource {
  CoreHttp coreHttp;

  LoginDataSourceImpl(this.coreHttp);

  @override
  Future<Account> login(Credentials credentials) async {
    var response = await coreHttp.post(
      route: '/account/auth',
      body: credentials.toJson(),
    );
    if (response.statusCode == 400) {
      throw LoginRequestError(
          response.data['message'] ?? 'Servidor indisponível');
    }
    coreHttp.addHeader(
      'Authorization',
      response.data['token'],
    );
    return Account.fromJson(response.data);
  }

  @override
  Future<Account> register(Credentials credentials) async{
    var response = await coreHttp.post(
      route: '/account/register',
      body: credentials.toJson(),
    );
    if (response.statusCode == 400) {
      throw LoginRequestError(
          response.data['message'] ?? 'Servidor indisponível');
    }
    return Account.fromJson(response.data);
  }

  @override
  Future<bool> registerCodeVerification(String code)async {
    var response = await coreHttp.get(
      route: 'account/confirmRegisterCode?$code',
    );
    if (response.statusCode == 400) {
      throw LoginRequestError(
          response.data['message'] ?? 'Servidor indisponível');
    }

    return response.data;
  }

  @override
  Future<bool> sendConfirmRegisterCode() async{
    var response = await coreHttp.get(
      route: 'account/sendConfirmRegisterCode',
    );
    if (response.statusCode == 400) {
      throw LoginRequestError(
          response.data['message'] ?? 'Servidor indisponível');
    }

    return response.data;
  }
}
