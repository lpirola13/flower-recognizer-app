import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

abstract class AuthBase{
  User get currentUser;
  Future <User> signInAnonymously();
  Future<void> signOut();
  Stream<User> authStateChanges();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
}

class Auth implements AuthBase{

  final _firebaseAuth = FirebaseAuth.instance;
  final _log = Logger('Auth');

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future <User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    _log.info('signInAnonymously - user ${userCredential.user.uid}');
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _log.info('signOut');
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    _log.info('signInWithEmailAndPassword - user ${userCredential.user.uid} - email ${userCredential.user.email}');
    return userCredential.user;
  }

  @override
  Future<User> createUserWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    _log.info('createUserWithEmailAndPassword - email ${userCredential.user.email}');
    return userCredential.user;
  }


}