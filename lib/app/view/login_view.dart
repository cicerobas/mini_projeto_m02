import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projeto_m02/app/bloc/login/login_bloc.dart';
import 'package:mini_projeto_m02/app/bloc/login/login_event.dart';
import 'package:mini_projeto_m02/app/bloc/login/login_state.dart';
import 'package:mini_projeto_m02/core/app_routes.dart';

class LoginView extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPassword = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<LoginBloc>().add(
      LoginSubmitted(username: _usernameController.text, password: _passwordController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .all(16),
          child: BlocConsumer<LoginBloc, LoginState>(
            builder: (context, state) {
              final isLoading = state is LoginLoading;

              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: .center,
                      child: Text(
                        "TODO's",
                        style: TextStyle(fontSize: 46, fontWeight: .bold, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 20),
                              labelText: "Usuário",
                              border: OutlineInputBorder(borderRadius: .circular(12)),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Campo obrigatório!";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 20),
                              labelText: "Senha",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() => _showPassword = !_showPassword);
                                },
                                icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                              ),
                              border: OutlineInputBorder(borderRadius: .circular(12)),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Campo obrigatório!";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: FilledButton(
                              onPressed: isLoading ? null : () => _login(context),
                              style: FilledButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: .circular(12))),
                              child: isLoading
                                  ? SizedBox(height: 30, width: 30, child: CircularProgressIndicator())
                                  : const Text("LOGIN", style: TextStyle(fontSize: 18, fontWeight: .w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            listener: (context, state) {
              if (state is LoginError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message, style: const TextStyle(color: Colors.white, fontSize: 18)),
                    backgroundColor: Theme.of(context).colorScheme.error,
                    behavior: .floating,
                    shape: RoundedRectangleBorder(borderRadius: .circular(12)),
                    margin: const .all(16),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
              if (state is LoginSuccess) {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              }
            },
          ),
        ),
      ),
    );
  }
}
