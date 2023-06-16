import 'package:fic4_flutter_auth_bloc/bloc/product/get_product_pagination/get_product_pagination_bloc.dart';
import 'package:fic4_flutter_auth_bloc/cubit/login/login_cubit.dart';
import 'package:fic4_flutter_auth_bloc/cubit/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/product/create_product/create_product_bloc.dart';
import 'bloc/product/edit_product/edit_product_bloc.dart';
import 'bloc/product/get_all_product/get_all_product_bloc.dart';
import 'bloc/product/get_one_product/get_one_product_bloc.dart';
import 'bloc/profile/profile_bloc.dart';
import 'bloc/register/register_bloc.dart';
import 'data/datasources/auth_datasources.dart';
import 'data/datasources/product_datasources.dart';
import 'presentation/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //bloc Register
        // BlocProvider(
        //   create: (context) => RegisterBloc(AuthDatasource()),
        // ),

        //cubit register
        BlocProvider(
          create: (context) => RegisterCubit(AuthDatasource()),
        ),

        //bloc login
        // BlocProvider(
        //   create: (context) => LoginBloc(AuthDatasource()),
        // ),

        //cubit login
        BlocProvider(
          create: (context) => LoginCubit(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => CreateProductBloc(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) => GetAllProductBloc(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) => EditProductBloc(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) => GetOneProductBloc(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) => GetProductPaginationBloc(ProductDatasources())
            ..add(GetProductPaginationStarted()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}

