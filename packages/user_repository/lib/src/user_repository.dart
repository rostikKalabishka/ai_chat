import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

import 'abstract_user_repository.dart';

import 'model/user_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io' show File;

class UserRepository implements AbstractUserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection('user');
  @override
  Future<UserModel> getMyUser(String myUserId) async {
    try {
      return usersCollection
          .doc(myUserId)
          .get()
          .then((value) => UserModel.fromJson(value.data()!));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserModel> registration(
      {required UserModel userModel, required String password}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: userModel.email, password: password);

      userModel = userModel.copyWith(id: userCredential.user?.uid);

      return userModel;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(UserModel userModel) async {
    try {
      await usersCollection.doc(userModel.id).set(userModel.toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateUserInfo(UserModel userModel) async {
    try {
      await usersCollection.doc(userModel.id).update(userModel.toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> uploadPicture(String file, String userId) async {
    try {
      File imageFile = File(file);
      Reference referenceStorageRef =
          FirebaseStorage.instance.ref().child('$userId//pp/${userId}_load');
      await referenceStorageRef.putFile(imageFile);
      String url = await referenceStorageRef.getDownloadURL();

      await usersCollection.doc(userId).update({'userImage': url});

      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
      if (firebaseUser == null) {
        yield UserModel.emptyUser;
      } else {
        try {
          final userDoc = await usersCollection.doc(firebaseUser.uid).get();
          if (userDoc.exists) {
            yield UserModel.fromJson(userDoc.data()!);
          } else {
            yield UserModel.emptyUser;
          }
        } catch (e) {
          log('Error fetching user data: $e');
          yield UserModel.emptyUser;
        }
      }
    });
  }
}
