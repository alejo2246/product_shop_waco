import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:product_shop/data/repositories/auth_repository.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthRepository get _authRepository =>
      Provider.of<AuthRepository>(context, listen: false);

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  Widget _userProfile(User? user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(user?.photoURL ??
              'https://www.pngfind.com/pngs/m/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.png'),
        ),
        const SizedBox(height: 20),
        Text(
          user?.displayName ?? 'Display Name',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          user?.email ?? 'User Email',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: signOut,
          child: const Text('Sign Out'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _authRepository.currentUser;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: _userProfile(user),
      ),
    );
  }
}
