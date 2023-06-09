import 'package:fic4_flutter_auth_bloc/cubit/register/register_cubit.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/register_model.dart';
import 'package:fic4_flutter_auth_bloc/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'name is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Name'),
                controller: nameController,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || !value.contains("@")) {
                    return 'Format email salah atau email kosong';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'password is required';
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                controller: passwordController,
              ),
              const SizedBox(
                height: 16,
              ),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  // if (state is RegisterLoaded) {
                  //   nameController!.clear();
                  //   emailController!.clear();
                  //   passwordController!.clear();
                  //   //navigasi
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //         backgroundColor: Colors.blue,
                  //         content: Text(
                  //             'success register with id: ${state.model.id}')),
                  //   );
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) {
                  //     return const LoginPage();
                  //   }));
                  // }
                  state.maybeWhen(
                      orElse: () {},
                      loaded: (model) {
                        nameController!.clear();
                        emailController!.clear();
                        passwordController!.clear();
                        //navigasi
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: Colors.blue,
                              content: Text(
                                  'success register with id: ${model.id}')),
                        );
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginPage();
                        }));
                      },
                      error: (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: Colors.red,
                              content:
                                  Text('error register with message: $error')),
                        );
                      });
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return ElevatedButton(
                        onPressed: () {
                          final requestModel = RegisterModel(
                            name: nameController!.text,
                            email: emailController!.text,
                            password: passwordController!.text,
                          );

                          if (_formKey.currentState!.validate()) {
                            context
                                .read<RegisterCubit>()
                                .register(requestModel);
                          }
                        },
                        child: const Text('Register'),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const LoginPage();
                  // }));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false);
                },
                child: const Text(
                  'Sudah Punya Akun? Login',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
