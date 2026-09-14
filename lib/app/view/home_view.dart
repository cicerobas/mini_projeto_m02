import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projeto_m02/app/bloc/home/home_bloc.dart';
import 'package:mini_projeto_m02/app/bloc/home/home_event.dart';
import 'package:mini_projeto_m02/app/bloc/home/home_state.dart';
import 'package:mini_projeto_m02/app/shared/widgets/search_field.dart';
import 'package:mini_projeto_m02/core/app_routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.userName),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => context.read<HomeBloc>().add(HomeLogoutRequested()),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: Column(
            children: [
              SizedBox(height: 10),
              SearchField(onChanged: (value) => context.read<HomeBloc>().add(HomeSearchChanged(value))),
              SizedBox(height: 10),
              SegmentedButton<TodoFilter>(
                showSelectedIcon: false,
                style: ButtonStyle(
                  textStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 16)),
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Theme.of(context).colorScheme.primary;
                    }
                    return Theme.of(context).colorScheme.surface;
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Theme.of(context).colorScheme.onPrimary;
                    }
                    return Theme.of(context).colorScheme.onSurface;
                  }),
                ),
                segments: [
                  ButtonSegment(value: TodoFilter.all, label: Text("Todas")),
                  ButtonSegment(value: TodoFilter.completed, label: Text("Concluídas")),
                  ButtonSegment(value: TodoFilter.incomplete, label: Text("Pendentes")),
                ],
                selected: {state.filter},
                onSelectionChanged: (selected) {
                  context.read<HomeBloc>().add(HomeFilterChanged(selected.first));
                },
              ),
              Divider(),
              Expanded(
                child: switch (state.status) {
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

                  HomeStatus.loggedOut => const SizedBox.shrink(),
                  HomeStatus.success => Padding(
                    padding: const .symmetric(horizontal: 8),
                    child: ListView.builder(
                      itemCount: state.filteredTodoList.length,
                      itemBuilder: (context, index) {
                        final todo = state.filteredTodoList[index];
                        return Opacity(
                          opacity: todo.completed ? 0.5 : 1.0,
                          child: Card(
                            child: ListTile(
                              title: Text(
                                todo.todo,
                                style: TextStyle(fontSize: 20, decoration: todo.completed ? .lineThrough : .none),
                              ),
                              leading: Checkbox(
                                value: todo.completed,
                                onChanged: (_) {
                                  context.read<HomeBloc>().add(HomeTodoToggled(todo.id));
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                },
              ),
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state.status == HomeStatus.loggedOut) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      },
    );
  }
}
