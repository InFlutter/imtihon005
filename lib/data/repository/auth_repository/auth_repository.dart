
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../network/network_response.dart';

class AuthRepository {
  Future<NetworkResponse> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        return NetworkResponse(
          errorMessage: 'no_internet_connection',
        );
      }
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        return NetworkResponse(
          data: user,
        );
      } else {
        return NetworkResponse(
          errorMessage: "no_working_api",
        );
      }
    } catch (error) {
      return NetworkResponse(
        errorMessage: error.toString(),
      );
    }
  }

  Future<NetworkResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        return NetworkResponse(
          errorMessage: 'no_internet_connection',
        );
      }
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        return NetworkResponse(
          data: user,
        );
      } else {
        return NetworkResponse(
          errorMessage: "no_working_api",
        );
      }
    }catch (error) {
      return NetworkResponse(
        errorMessage: error.toString(),
      );
    }
  }

  Future<NetworkResponse> signInWithGoogle() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        return NetworkResponse(
          errorMessage: 'no_internet_connection',
        );
      }
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;
        if (user != null) {
          return NetworkResponse(
            data: user,
          );
        } else {
          return NetworkResponse(
            errorMessage: 'no_working_api',
          );
        }
      }
      return NetworkResponse(
        errorMessage: 'no_authentication',
      );
    } catch (error) {
      return NetworkResponse(
        errorMessage: error.toString(),
      );
    }
  }
}