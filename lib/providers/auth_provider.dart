import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/user.dart';

class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Uuid _uuid = const Uuid();

  AuthNotifier() : super(AuthState());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    try {
      // In real app, call backend API here
      final user = User(
        id: _uuid.v4(),
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      state = state.copyWith(
        user: user,
        isAuthenticated: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    try {
      // In real app, call backend API here
      // For demo, create a mock user
      final user = User(
        id: _uuid.v4(),
        name: email.split('@')[0],
        email: email,
        bio: 'Crypto enthusiast and trader',
        createdAt: DateTime.now(),
        followersCount: 42,
        followingCount: 28,
        postsCount: 15,
      );

      state = state.copyWith(
        user: user,
        isAuthenticated: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    state = AuthState();
  }

  void updateProfile({
    String? name,
    String? bio,
  }) {
    if (state.user != null) {
      state = state.copyWith(
        user: state.user!.copyWith(
          name: name,
          bio: bio,
        ),
      );
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
