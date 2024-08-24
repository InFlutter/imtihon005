import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon005/cubit/user_cubit/user_cubit.dart';
import 'package:imtihon005/cubit/user_cubit/user_state.dart';

import '../../../data/model/forms_status.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showEditUserDialog(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state.status == FormsStatus.success) {
            final user = state.userModel;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('First Name: ${user.firstName}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Last Name: ${user.lastName}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
                ],
              ),
            );
          } else if (state.status == FormsStatus.error) {
            return Center(
              child: Text('Error: ${state.errorMessage}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _showEditUserDialog(BuildContext context) {
    final user = context.read<UserCubit>().state.userModel;

    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.email;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit User Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedUser = user.copyWith(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                );

                context.read<UserCubit>().updateUser(userModel: updatedUser);

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
