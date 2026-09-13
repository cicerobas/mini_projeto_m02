import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projeto_m02/app/bloc/home/home_bloc.dart';
import 'package:mini_projeto_m02/app/bloc/home/home_event.dart';
import 'package:mini_projeto_m02/app/bloc/home/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) => Text(state.userName))),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state.status) {
            HomeStatus.initial || HomeStatus.loading => const Center(child: CircularProgressIndicator()),
            HomeStatus.error => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.errorMessage ?? 'Erro desconhecido'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<HomeBloc>().add(HomeRetryRequested()),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            ),
            HomeStatus.success => ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return Card(child: ListTile(title: Text(todo.todo)));
              },
            ),
          };
        },
      ),
    );
  }
}
