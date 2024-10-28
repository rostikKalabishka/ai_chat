import 'model/user_model.dart';

abstract interface class AbstractUserRepository {
  Future registration({required UserModel userModel, required String password});

  Future<void> login({required String email, required String password});

  Future<void> resetPassword({required String email});

  Future<void> logOut();

  Stream<UserModel?> get user;

  Future<void> setUserData(UserModel userModel);

  Future<UserModel> getMyUser(String myUserId);

  Future<String> uploadPicture(String file, String userId);

  Future<void> updateUserInfo(UserModel userModel);
}
