import '../../../../core/http/core_http.dart';
import '../../domain/models/credentials.dart';
import '../exeptions/account_exeptions.dart';

abstract class AccountDataSource {
  Future<void> login(Credentials credentials);
}

class LoginDataSourceImpl implements AccountDataSource {
  CoreHttp coreHttp;

  LoginDataSourceImpl(this.coreHttp);

  @override
  Future<void> login(Credentials credentials) async {
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
  }
}
