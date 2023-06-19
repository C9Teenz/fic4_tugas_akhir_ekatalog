import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/login/login_cubit.dart';
import 'cubit/product/add_product/add_product_cubit.dart';
import 'cubit/product/products_pagination/products_pagination_cubit.dart';
import 'cubit/product/update_product/update_product_cubit.dart';
import 'cubit/profile/profile_cubit.dart';
import 'cubit/register/register_cubit.dart';
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
        //bloc
        // BlocProvider(
        //   create: (context) => RegisterBloc(AuthDatasource()),
        // ),
        // BlocProvider(
        //   create: (context) => LoginBloc(AuthDatasource()),
        // ),
        //   BlocProvider(
        //   create: (context) => ProfileBloc(),
        // ),
        // BlocProvider(
        //   create: (context) => GetAllProductBloc(ProductDatasources()),
        // ),
        // BlocProvider(
        //   create: (context) => GetProductPaginationBloc(ProductDatasources())
        //     ..add(GetProductPaginationStarted()),
        // ),
        //   BlocProvider(
        //   create: (context) => CreateProductBloc(ProductDatasources()),
        // ),
        //   BlocProvider(
        //   create: (context) => EditProductBloc(ProductDatasources()),
        // ),
        // BlocProvider(
        //   create: (context) => GetOneProductBloc(ProductDatasources()),
        // ),

        //cubit
        BlocProvider(
          create: (context) => RegisterCubit(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginCubit(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
          BlocProvider(
          create: (context) => ProductsPaginationCubit(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) => AddProductCubit(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) => UpdateProductCubit(ProductDatasources()),
        ),
    
      
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
