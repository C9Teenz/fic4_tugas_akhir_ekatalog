import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../cubit/login/login_cubit.dart';
import '../../data/localsources/auth_local_storage.dart';
import '../../data/models/request/login_model.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
    isLogin();
  }

  void isLogin() async {
    final isTokenExist = await AuthLocalStorage().isTokenExist();
    if (isTokenExist) {
      final token = await AuthLocalStorage().getToken();
      var headers = {'Authorization': 'Bearer $token'};
      final response = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/auth/profile'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false);
        }
      } else {
        AuthLocalStorage().removeToken();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();

    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login App'),
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
                  if (value == null || !value.contains("@")) {
                    return "pastikan email seudah sesuai atau tidak kosong";
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "pastikan password tidak kosong";
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
              //bloc
              // BlocConsumer<LoginBloc, LoginState>
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  //   if (state is LoginLoaded) {
                  //     emailController!.clear();
                  //     passwordController!.clear();
                  //     //navigasi
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //           backgroundColor: Colors.blue,
                  //           content: Text('Success Login')),
                  //     );

                  //     // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //     //   return const HomePage();
                  //     // }));
                  //     Navigator.of(context).pushAndRemoveUntil(
                  //         MaterialPageRoute(
                  //           builder: (context) => const HomePage(),
                  //         ),
                  //         (route) => false);
                  //   }
                  //   if (state is LoginError) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //           backgroundColor: Colors.red,
                  //           content: Text('Failed Login')),
                  //     );
                  //   }
                  state.maybeWhen(
                    orElse: () {},
                    loaded: (data) {
                      emailController!.clear();
                      passwordController!.clear();
                      //navigasi
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.blue,
                            content: Text('Success Login')),
                      );

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false);
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(message)),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return ElevatedButton(
                        onPressed: () {
                          final requestModel = LoginModel(
                            email: emailController!.text,
                            password: passwordController!.text,
                          );
                          if (_formKey.currentState!.validate()) {
                            //bloc
                            // context
                            //     .read<LoginBloc>()
                            //     .add(DoLoginEvent(loginModel: requestModel));
                            //Cubit
                            context.read<LoginCubit>().login(requestModel);
                          }
                        },
                        child: const Text('Login'),
                      );
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const RegisterPage();
                  // }));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                      (route) => false);
                },
                child: const Text(
                  'Belum Punya Akun? Register',
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
