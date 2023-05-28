import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart as model';
import 'package:beebeer_app/core/core.dart';
import 'package:fpdart/fpdart.dart';

// want to signup, want to get user account --> Account
// want to access user related data --> model.Account

abstract class IAuthAPI {
  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  });
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;
  @override
  FutureEither<Account> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.create(
          userId: ID.unique(), email: email, password: password);
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      Failure(e.toString(), stackTrace);
    }
  }
}
