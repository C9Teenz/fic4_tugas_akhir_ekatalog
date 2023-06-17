import '../../bloc/product/create_product/create_product_bloc.dart';

import '../../bloc/product/get_one_product/get_one_product_bloc.dart';

import '../../cubit/product/products_pagination/products_pagination_cubit.dart';
import '../../cubit/profile/profile_cubit.dart';

import '../../data/localsources/auth_local_storage.dart';
import '../../data/models/request/product_model.dart';
import '../../data/models/response/product/product_response_model.dart';
import 'detail_product_page.dart';
import '../widgets/card_widget.dart';
import '../widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/edit_product/edit_product_bloc.dart';
import '../../data/models/request/product_model_update.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController updateTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
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
        print("mentok");
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
                                data: products[index], onClick: () {}),
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
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Product'),
                content: DialogWidget(
                  titleController: titleController,
                  priceController: priceController,
                  descriptionController: descriptionController,
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  BlocListener<CreateProductBloc, CreateProductState>(
                    listener: (context, state) {
                      if (state is CreateProductLoaded) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('${state.productResponseModel.id}')));
                        Navigator.pop(context);
                        context.read<ProductsPaginationCubit>().getProduct();
                      }
                    },
                    child: BlocBuilder<CreateProductBloc, CreateProductState>(
                      builder: (context, state) {
                        if (state is CreateProductLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                          onPressed: () {
                            final productModel = ProductModel(
                              title: titleController.text,
                              price: int.parse(priceController.text),
                              description: descriptionController.text,
                            );
                            context.read<CreateProductBloc>().add(
                                DoCreateProductEvent(
                                    productModel: productModel));
                          },
                          child: const Text('Save'),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // ListView listCard() {
  //   return ListView.builder(
  //       padding: const EdgeInsets.symmetric(horizontal: 16),
  //       controller: controller,
  //       itemCount: product.length,
  //       itemBuilder: ((context, index) {
  //         return GestureDetector(
  //           onTap: () {
  //             Navigator.of(context).push(MaterialPageRoute(
  //               builder: (context) => DetailProductPage(data: product[index]),
  //             ));
  //           },
  //           child: CardWidget(
  //             data: product[index],
  //             onClick: () {
  //               context
  //                   .read<GetOneProductBloc>()
  //                   .add(DoGetOneProductEvent(id: product[index].id));
  //               showDialog(
  //                 context: context,
  //                 builder: (context) {
  //                   return AlertDialog(
  //                     title: const Text('Edit Product'),
  //                     content:
  //                         BlocBuilder<GetOneProductBloc, GetOneProductState>(
  //                       builder: (context, state) {
  //                         if (state is GetOneProductLoaded) {
  //                           updateTitleController.text = state.product.title;
  //                           updatePriceController.text =
  //                               state.product.price.toString();
  //                           updateDescriptionController.text =
  //                               state.product.description;
  //                           return DialogWidget(
  //                               titleController: updateTitleController,
  //                               priceController: updatePriceController,
  //                               descriptionController:
  //                                   updateDescriptionController);
  //                         } else {
  //                           return const Center(
  //                             child: CircularProgressIndicator(),
  //                           );
  //                         }
  //                       },
  //                     ),
  //                     actions: [
  //                       ElevatedButton(
  //                         onPressed: () {
  //                           Navigator.pop(context);
  //                         },
  //                         child: const Text('Cancel'),
  //                       ),
  //                       const SizedBox(
  //                         width: 4,
  //                       ),
  //                       BlocListener<EditProductBloc, EditProductState>(
  //                         listener: (context, state) {
  //                           if (state is EditProductLoaded) {
  //                             updateTitleController.clear();
  //                             updatePriceController.clear();
  //                             updateDescriptionController.clear();
  //                             ScaffoldMessenger.of(context).showSnackBar(
  //                                 const SnackBar(content: Text('xxx')));
  //                             Navigator.pop(context);
  //                             // context
  //                             //     .read<GetAllProductBloc>()
  //                             //     .add(DoGetAllProductEvent());
  //                             context
  //                                 .read<GetProductPaginationBloc>()
  //                                 .add(GetProductPaginationStarted());
  //                           }
  //                         },
  //                         child: BlocBuilder<EditProductBloc, EditProductState>(
  //                           builder: (context, state) {
  //                             if (state is EditProductLoading) {
  //                               return const Center(
  //                                 child: CircularProgressIndicator(),
  //                               );
  //                             }
  //                             return ElevatedButton(
  //                               onPressed: () {
  //                                 final productModel = ProductModelUpdate(
  //                                   title: updateTitleController.text,
  //                                   price:
  //                                       int.parse(updatePriceController.text),
  //                                   description:
  //                                       updateDescriptionController.text,
  //                                 );

  //                                 context.read<EditProductBloc>().add(
  //                                     DoUpdateProductEvent(
  //                                         productModel: productModel,
  //                                         id: product[index].id!));
  //                               },
  //                               child: const Text('Save'),
  //                             );
  //                           },
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 },
  //               );
  //             },
  //           ),
  //         );
  //       }));
  // }
}
