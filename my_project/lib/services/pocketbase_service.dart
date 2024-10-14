// lib/services/pocketbase_service.dart
import 'package:pocketbase/pocketbase.dart';

class PocketbaseService {
  final PocketBase pb = PocketBase('http://localhost:8090');

    Future<void> register(String email, String password) async {
        try {
        final response = await pb.collection('users').create(body: {
            'email': email,
            'password': password,
            'passwordConfirm': password,
            'role': 'member'
        });
        print('Registration successful: $response');
        } catch (e) {
        print('Error during registration: $e');
        }
    }

    Future<RecordModel?> login(String email, String password) async {
    try {
      final authData = await pb.collection('users').authWithPassword(email, password);
      print('User Login successful: ${authData.record}');
      return authData.record;
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

    Future<void> logout() async {
        final user = pb.authStore.model;
        print('Data : $user');
        pb.authStore.clear();
        print('Logged out');
    }

    Future<List<dynamic>> getDataBasedOnRole() async {
    try {
        final user = pb.authStore.model;
        final records = await pb.collection('posts').getFullList();
        return records;
    } catch (e) {
        print('Error fetching data: $e');
        return [];
    }
   }

    Future<void> createData(String title, String content) async {
        try {
        await pb.collection('posts').create(body: {
            'title': title,
            'content': content,
        });
        print('Data created successfully');
        } catch (e) {
        print('Error creating data: $e');
        }
  }

    Future<void> updateData(String recordId, String title, String content) async {
        try {
        await pb.collection('posts').update(recordId, body: {
            'title': title,
            'content': content,
        });
        print('Data updated successfully');
        } catch (e) {
        print('Error updating data: $e');
        }
    }

    Future<void> deleteData(String recordId) async {
        try {
        await pb.collection('posts').delete(recordId);
        print('Data deleted successfully');
        } catch (e) {
        print('Error deleting data: $e');
        }
    }
}