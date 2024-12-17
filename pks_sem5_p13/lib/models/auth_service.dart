
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> login(String email, String password) async {
      return await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<AuthResponse> register( String email, String password, String name) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        "display_name": name
      }
    );
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  User? getCurrentUser() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user;
  }
}