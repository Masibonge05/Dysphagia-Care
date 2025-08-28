import 'package:firebase_auth/firebase_auth.dart';

/// A lightweight wrapper around `FirebaseAuth` that keeps the rest of
/// your codebase clean and gives you friendly error messages.
class AuthService {
  // Singleton FirebaseAuth instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Expose auth‑state changes so the UI can react (e.g., show Home vs Login).
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  
  /// Get the current user
  User? get currentUser => _firebaseAuth.currentUser;
  
  /// Check if a user is signed in
  bool get isSignedIn => currentUser != null;

  /// Sign up with e‑mail & password
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException.from(e);
    } catch (e) {
      throw AuthException('An unexpected error occurred: $e');
    }
  }

  /// Sign in with e‑mail & password
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException.from(e);
    } catch (e) {
      throw AuthException('An unexpected error occurred: $e');
    }
  }
  
  /// Sign in anonymously
  Future<UserCredential> signInAnonymously() async {
    try {
      return await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw AuthException.from(e);
    } catch (e) {
      throw AuthException('An unexpected error occurred: $e');
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw AuthException.from(e);
    } catch (e) {
      throw AuthException('An unexpected error occurred: $e');
    }
  }
  
  /// Update user profile
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateDisplayName(displayName);
        await user.updatePhotoURL(photoURL);
      } else {
        throw AuthException('No user is currently signed in');
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException.from(e);
    } catch (e) {
      throw AuthException('An unexpected error occurred: $e');
    }
  }
  
  /// Update user email
  Future<void> updateEmail(String newEmail) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail.trim());
      } else {
        throw AuthException('No user is currently signed in');
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException.from(e);
    } catch (e) {
      throw AuthException('An unexpected error occurred: $e');
    }
  }
  
  /// Update user password
  Future<void> updatePassword(String newPassword) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw AuthException('No user is currently signed in');
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException.from(e);
    } catch (e) {
      throw AuthException('An unexpected error occurred: $e');
    }
  }

  /// Sign the current user out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException('Error signing out: $e');
    }
  }

  /// Permanently delete the current user's account
  Future<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.delete();
      } else {
        throw AuthException('No user is currently signed in');
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException.from(e);
    } catch (e) {
      throw AuthException('An unexpected error occurred: $e');
    }
  }
  
  /// Re-authenticate the user
  /// This is often required before sensitive operations like changing email, password, or deleting account
  Future<UserCredential> reauthenticate(String password) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null && user.email != null) {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        return await user.reauthenticateWithCredential(credential);
      } else {
        throw AuthException('User is not signed in or has no email');
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException.from(e);
    } catch (e) {
      throw AuthException('An unexpected error occurred: $e');
    }
  }
}

/// Turns raw `FirebaseAuthException`s into human‑readable text so
/// your widgets can simply display `e.message`.
class AuthException implements Exception {
  AuthException(this.message);
  final String message;

  factory AuthException.from(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return AuthException('That e‑mail address is not valid.');
      case 'user-disabled':
        return AuthException('This user has been disabled.');
      case 'user-not-found':
        return AuthException('No user found for that e‑mail.');
      case 'wrong-password':
        return AuthException('Incorrect password.');
      case 'email-already-in-use':
        return AuthException('An account already exists for that e‑mail.');
      case 'weak-password':
        return AuthException('Please choose a stronger password.');
      case 'operation-not-allowed':
        return AuthException('Email/password accounts are not enabled.');
      case 'requires-recent-login':
        return AuthException('Please log in again before retrying this operation.');
      case 'too-many-requests':
        return AuthException('Too many unsuccessful login attempts. Try again later.');
      case 'account-exists-with-different-credential':
        return AuthException('An account already exists with the same email but different sign-in credentials.');
      case 'invalid-credential':
        return AuthException('Invalid username or password. Please try again.');
      case 'network-request-failed':
        return AuthException('A network error occurred. Please check your connection.');
      default:
        return AuthException('Authentication error: ${e.code}');
    }
  }

  @override
  String toString() => message;
}