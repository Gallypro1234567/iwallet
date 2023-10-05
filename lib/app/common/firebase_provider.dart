import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iwallet/app/models/expenses_model.dart';
import 'package:iwallet/app/widgets/loading_dialog.dart';

import 'help_function.dart';

class FirebaseProvider {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;
  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class FireStoreProvider {
  static const timeOut = Duration(minutes: 2);

// Thêm một chi tiêu mới
  static Future<Result<DocumentReference>> addExpense(
      String userId, Map<String, dynamic> expenseData) async {
    return await FirebaseFirestore.instance
        .collection('expenses')
        .doc(userId)
        .collection('user_expenses')
        .add(expenseData)
        .then((DocumentReference result) {
          return Result(result: result);
        })
        .onError((error, stackTrace) => Result(httpMessage: error.toString()))
        .timeout(timeOut);
  }

// Lấy danh sách các chi tiêu của người dùng
  static Stream<QuerySnapshot> getUserExpenses(String userId) {
    return FirebaseFirestore.instance
        .collection('expenses')
        .doc(userId)
        .collection('user_expenses')
        .snapshots();
  }

// Cập nhật một chi tiêu
  static Future<Result<bool>> updateExpense(
      String userId, String expenseId, Map<String, dynamic> updatedData) async {
    return await FirebaseFirestore.instance
        .collection('expenses')
        .doc(userId)
        .collection('user_expenses')
        .doc(expenseId)
        .update(updatedData)
        .then((result) {
          return Result(result: true);
        })
        .onError((error, stackTrace) => Result(httpMessage: error.toString()))
        .timeout(timeOut);
  }

// Xóa một chi tiêu
  static Future<Result<bool>> deleteExpense(
      String userId, String expenseId) async {
    return await FirebaseFirestore.instance
        .collection('expenses')
        .doc(userId)
        .collection('user_expenses')
        .doc(expenseId)
        .delete()
        .then((result) {
          return Result(result: true);
        })
        .onError((error, stackTrace) => Result(httpMessage: error.toString()))
        .timeout(timeOut);
  }
}
