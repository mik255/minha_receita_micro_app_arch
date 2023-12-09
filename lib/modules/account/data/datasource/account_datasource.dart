import 'package:minha_receita/core/common_http/common_http.dart';
import '../../domain/models/credentials.dart';
import '../exeptions/account_exeptions.dart';

abstract class AccountDataSource {
  Future<void> login(Credentials credentials);
}

class LoginDataSourceImpl implements AccountDataSource {
  CommonHttp commonHttp;

  LoginDataSourceImpl(this.commonHttp);

  @override
  Future<void> login(Credentials credentials) async {
    var response = await commonHttp.post(
      route: '/account/auth',
      body: credentials.toJson(),
    );
    if (response.statusCode == 400) {
      throw LoginRequestError(
          response.data['message'] ?? 'Servidor indisponível');
    }
    CommonHttp.instance!.addHeader(
      'Authorization',
      response.data['token'],
    );
  }
}
