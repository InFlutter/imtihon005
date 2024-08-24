import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon005/cubit/recep_cubit/recep_cubit.dart';
import 'package:imtihon005/cubit/recep_cubit/recep_state.dart';
import 'package:imtihon005/data/model/forms_status.dart';
import '../../../data/model/recep_model/recep_model.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final _recepNameController = TextEditingController();
  final _recepDescriptionController = TextEditingController();
  final _recepProductsController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _showAddRecepDialog(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<RecepCubit, RecepState>(
        builder: (BuildContext context, RecepState state) {
          if (state.status == FormsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: state.listRecep.length,
            itemBuilder: (context, index) {
              final recep = state.listRecep[index];
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(recep.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _showEditRecepDialog(context, recep);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  context.read<RecepCubit>().deleteRecep(uid: recep.uid);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      recep.recepName,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text('Description: ${recep.recepDescription}'),
                    Text('Products: ${recep.recepProducts.join(', ')}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddRecepDialog(BuildContext context) {
    _clearControllers();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Recep'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _recepNameController,
                decoration: const InputDecoration(labelText: 'Recep Name'),
              ),
              TextField(
                controller: _recepDescriptionController,
                decoration: const InputDecoration(labelText: 'Recep Description'),
              ),
              TextField(
                controller: _recepProductsController,
                decoration: const InputDecoration(labelText: 'Recep Products (comma separated)'),
              ),
              TextField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Image URL'),
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
                final newRecep = RecepModel(
                  recepName: _recepNameController.text,
                  recepDescription: _recepDescriptionController.text,
                  recepProducts: _recepProductsController.text.split(','),
                  image: _imageController.text,
                  uid: UniqueKey().toString(), // Or use a more suitable method for generating UID
                );

                context.read<RecepCubit>().insertRecep(recepModel: newRecep);

                Navigator.of(context).pop();
                _clearControllers();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditRecepDialog(BuildContext context, RecepModel recep) {
    _recepNameController.text = recep.recepName;
    _recepDescriptionController.text = recep.recepDescription;
    _recepProductsController.text = recep.recepProducts.join(',');
    _imageController.text = recep.image;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Recep'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _recepNameController,
                decoration: const InputDecoration(labelText: 'Recep Name'),
              ),
              TextField(
                controller: _recepDescriptionController,
                decoration: const InputDecoration(labelText: 'Recep Description'),
              ),
              TextField(
                controller: _recepProductsController,
                decoration: const InputDecoration(labelText: 'Recep Products (comma separated)'),
              ),
              TextField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Image URL'),
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
                final updatedRecep = recep.copyWith(
                  recepName: _recepNameController.text,
                  recepDescription: _recepDescriptionController.text,
                  recepProducts: _recepProductsController.text.split(','),
                  image: _imageController.text,
                );

                context.read<RecepCubit>().updateRecep(recepModel: updatedRecep);

                Navigator.of(context).pop();
                _clearControllers();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _clearControllers() {
    _recepNameController.clear();
    _recepDescriptionController.clear();
    _recepProductsController.clear();
    _imageController.clear();
  }
}
