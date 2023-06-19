import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/product/products_pagination/products_pagination_cubit.dart';
import '../../cubit/profile/profile_cubit.dart';
import '../../data/localsources/auth_local_storage.dart';
import '../../data/models/response/product/product_response_model.dart';
import '../widgets/card_widget.dart';
import 'add_product_page.dart';
import 'detail_product_page.dart';
import 'login_page.dart';
import 'update_product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController updateDescriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController updatePriceController = TextEditingController();
  final controller = ScrollController();
  List<ProductResponseModel> product = [];
  int newOffset = 0;
  int newLimit = 10;
  bool newIsNext = true;

  @override
  void initState() {
    context.read<ProfileCubit>().getProfile();
    context.read<ProductsPaginationCubit>().getProduct();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text("mentok bro")));
       
        context.read<ProductsPaginationCubit>().nextProduct(
            offset: newOffset,
            isNext: newIsNext,
            limit: newLimit,
            products: product);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home - Profile'),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthLocalStorage()
                    .removeToken()
                    .then((_) => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (route) => false));
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: Text("No Data"),
                  );
                },
                loaded: (model) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(model.name),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(model.email),
                    ],
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (message) => Center(
                  child: Text(message),
                ),
              );
              // if (state is ProfileLoading) {
              //   return const Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              // if (state is ProfileLoaded) {
              //   return Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(state.profile.name ?? ''),
              //       const SizedBox(
              //         width: 8,
              //       ),
              //       Text(state.profile.email ?? ''),
              //     ],
              //   );
              // }
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                product = [];
                context.read<ProductsPaginationCubit>().getProduct();
              },
              child:
                  BlocBuilder<ProductsPaginationCubit, ProductsPaginationState>(
                builder: (context, state) {
                  // if (state.status == Status.initial) {
                  //   return const Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  // }
                  // if (state.status == Status.loaded) {
                  //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  //   product = state.products!;
                  //   return listCard();
                  // }
                  // if (product.isEmpty) {
                  //   return const Center(child: Text('no data'));
                  // } else {
                  //   return listCard();
                  // }
                  return state.maybeWhen(
                    orElse: () {
                      return const Center(
                        child: Text("No Data"),
                      );
                    },
                    loaded: (products, offset, limit, isNext) {
                      product = products;
                      newOffset = offset!;
                      newLimit = limit!;
                      newIsNext = isNext!;

                      return ListView.builder(
                        controller: controller,
                        itemBuilder: (context, index) {
                          if (isNext && index == products.length) {
                            return const Card(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    DetailProductPage(data: products[index]),
                              ));
                            },
                            child: CardWidget(
                                data: products[index], onClick: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    UpdateProductPage(data: products[index]),
                              ));
                                }),
                          );
                        },
                        itemCount:
                            isNext ? products.length + 1 : products.length,
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    error: (message) {
                      return Center(
                        child: Text(message),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddProductPage(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  
}
