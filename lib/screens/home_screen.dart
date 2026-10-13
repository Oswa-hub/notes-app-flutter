import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes App',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthProvider>().logout();

              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              'Hello, ${user?.name ?? 'User'}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 12),

            FilledButton(
              onPressed: () {
                context.go('/notes');
              },
              child: const Text(
                'Open my notes →',
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () async {
                await context.read<AuthProvider>().logout();

                if (context.mounted) {
                  context.go('/login');
                }
              },
              child: const Text(
                'Sign out',
              ),
            ),
          ],
        ),
      ),
    );
  }
}