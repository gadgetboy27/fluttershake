import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttershake/src/models/user.dart';
import 'package:fluttershake/src/services/firestore_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'dart:async';

final RegExp regExpEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class AuthBloc {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _user = BehaviorSubject<User>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirsestoreService _firsestoreService = FirsestoreService();

  //Get Data
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get isValid =>
      CombineLatestStream.combine2(email, password, (email, password) => true);
  Stream<User> get user => _user.stream;
  //Set Data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  get sink => null;

  dispose() {
    _email.close();
    _password.close();
    _user.close();
  }

  //Transformers
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (regExpEmail.hasMatch(email.trim())) {
      sink.add(email.trim());
    } else {
      sink.addError('Must be Valid Email Address');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 8) {
      sink.add(password.trim());
    } else {
      sink.addError('Password Must be 8 Char in Length');
    }
  });

  //Functions

  signupEmail() async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: _email.value.trim(), password: _password.value.trim());
      var user = User(userId: authResult.user.uid, email: _email.value.trim());
      await _firsestoreService.addUser(user);
      _user.sink.add(user);
    } catch (error) {
      print(error);
    }
  }

  loginEmail() async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: _email.value.trim(), password: _password.value.trim());
      var user = await _firsestoreService.fetchUser(authResult.user.uid);
      _user.sink.add(user);
    } catch (error) {
      print(error);
    }
  }

  Future<bool> isLoggedIn() async {
    var firebaseUser = await _auth.currentUser();
    if (firebaseUser == null) return false;

    var user = await _firsestoreService.fetchUser(firebaseUser.uid);
    if (user == null) return false;

    _user.sink.add(user);
    return true;
  }

  logout() async {
    await _auth.signOut();
    _user.sink.add(null);
  }
  
}
