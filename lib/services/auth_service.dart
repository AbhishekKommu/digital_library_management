import '../models/user.dart';

class AuthService {
  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  Future<bool> login(
    String email,
    String password,
  ) async {
    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (email.isNotEmpty && password.isNotEmpty) {
      _currentUser = User(
        id: 'USR001',
        name: 'Library User',
        email: email,
      );

      return true;
    }

    return false;
  }

  Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    _currentUser = User(
      id: 'USR001',
      name: name,
      email: email,
    );

    return true;
  }

  void logout() {
    _currentUser = null;
  }
}