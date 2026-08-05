import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/errors/exceptions.dart';
import '../models/user_model.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  FirebaseAuthService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  @override
  UserModel? get currentUser {
    final user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    return _toUserModel(user);
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return _auth.authStateChanges().map((user) {
      if (user == null) {
        return null;
      }

      return _toUserModel(user);
    });
  }

  @override
  Future<UserModel> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw const AuthException(
          'Não foi possível realizar o login.',
        );
      }

      await _createUserDocument(user);

      return _toUserModel(user);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_firebaseMessage(e));
    } catch (_) {
      throw const AuthException(
        'Erro inesperado ao realizar login.',
      );
    }
  }

  @override
  Future<UserModel> createUserWithEmail(
    String name,
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw const AuthException(
          'Não foi possível criar a conta.',
        );
      }

      await user.updateDisplayName(name);

      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'photoUrl': user.photoURL,
        'emailVerified': user.emailVerified,
        'plan': 'free',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return UserModel(
        id: user.uid,
        name: name,
        email: email,
        photoUrl: user.photoURL,
        emailVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(_firebaseMessage(e));
    } catch (_) {
      throw const AuthException(
        'Erro ao criar conta.',
      );
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();

      final account = await _googleSignIn.authenticate();

      final authentication = account.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
      );

      final result = await _auth.signInWithCredential(
        credential,
      );

      final user = result.user;

      if (user == null) {
        throw const AuthException(
          'Falha no login com Google.',
        );
      }

      await _firestore.collection('users').doc(user.uid).set({
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'photoUrl': user.photoURL,
        'emailVerified': user.emailVerified,
        'plan': 'free',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return _toUserModel(user);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_firebaseMessage(e));
    } catch (_) {
      throw const AuthException(
        'Erro no login com Google.',
      );
    }
  }

  @override
  Future<void> sendPasswordResetEmail(
    String email,
  ) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(_firebaseMessage(e));
    } catch (_) {
      throw const AuthException(
        'Erro ao enviar e-mail de recuperação.',
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {}

    await _auth.signOut();
  }

  Future<void> _createUserDocument(
    User user,
  ) async {
    final doc = _firestore.collection('users').doc(user.uid);

    final snapshot = await doc.get();

    if (snapshot.exists) {
      await doc.update({
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return;
    }

    await doc.set({
      'name': user.displayName ?? '',
      'email': user.email ?? '',
      'photoUrl': user.photoURL,
      'emailVerified': user.emailVerified,
      'plan': 'free',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  UserModel _toUserModel(User user) {
    return UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL,
      emailVerified: user.emailVerified,
      plan: PlanType.free,
    );
  }

  String _firebaseMessage(
    FirebaseAuthException e,
  ) {
    switch (e.code) {
      case 'invalid-email':
        return 'E-mail inválido.';

      case 'user-disabled':
        return 'Usuário desativado.';

      case 'user-not-found':
        return 'Usuário não encontrado.';

      case 'wrong-password':
        return 'Senha incorreta.';

      case 'email-already-in-use':
        return 'Este e-mail já está em uso.';

      case 'weak-password':
        return 'A senha deve possuir pelo menos 6 caracteres.';

      case 'network-request-failed':
        return 'Sem conexão com a internet.';

      case 'too-many-requests':
        return 'Muitas tentativas. Tente novamente mais tarde.';

      case 'invalid-credential':
        return 'Credenciais inválidas.';

      default:
        return e.message ?? 'Erro de autenticação.';
    }
  }
}
