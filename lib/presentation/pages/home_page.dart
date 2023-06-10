import 'package:fic4_flutter_auth_bloc/bloc/product/create_product/create_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product/get_all_product/get_all_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product/get_one_product/get_one_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product/get_product_pagination/get_product_pagination_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/profile/profile_bloc.dart';
import 'package:fic4_flutter_auth_bloc/data/localsources/auth_local_storage.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/product_response_model.dart';
import 'package:fic4_flutter_auth_bloc/presentation/widgets/card_widget.dart';
import 'package:fic4_flutter_auth_bloc/presentation/widgets/dialog_widget.dart';
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
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    // context.read<GetAllProductBloc>().add(DoGetAllProductEvent());

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        context
            .read<GetProductPaginationBloc>()
            .add(GetProductPaginationLoadMore());
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
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return const LoginPage();
                // }));
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileLoaded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.profile.name ?? ''),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(state.profile.email ?? ''),
                ],
              );
            }

            return const Text('no data');
          }),
          // Expanded(
          //   child: BlocBuilder<GetAllProductBloc, GetAllProductState>(
          //     builder: (context, state) {
          //       if (state is GetAllProductLoading) {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //       if (state is GetALlProductLoaded) {
          //         return ListView.builder(
          //             padding: const EdgeInsets.symmetric(horizontal: 16),
          //             itemCount: state.listProduct.length,
          //             itemBuilder: ((context, index) {
          //               final product =
          //                   state.listProduct.reversed.toList()[index];
          //               return GestureDetector(
          //                 onTap: () {
          //                   context
          //                       .read<GetOneProductBloc>()
          //                       .add(DoGetOneProductEvent(id: product.id!));
          //                   showDialog(
          //                     context: context,
          //                     builder: (context) {
          //                       return AlertDialog(
          //                         title: const Text('Edit Product'),
          //                         content: BlocBuilder<GetOneProductBloc,
          //                             GetOneProductState>(
          //                           builder: (context, state) {
          //                             if (state is GetOneProductLoaded) {
          //                               updateTitleController.text =
          //                                   state.product.title!;
          //                               updatePriceController.text =
          //                                   state.product.price.toString();
          //                               updateDescriptionController.text =
          //                                   state.product.description!;
          //                               return Column(
          //                                 mainAxisSize: MainAxisSize.min,
          //                                 children: [
          //                                   TextField(
          //                                     decoration: const InputDecoration(
          //                                         labelText: 'Title'),
          //                                     controller: updateTitleController,
          //                                   ),
          //                                   TextField(
          //                                     decoration: const InputDecoration(
          //                                         labelText: 'Price'),
          //                                     controller: updatePriceController,
          //                                     keyboardType:
          //                                         TextInputType.number,
          //                                   ),
          //                                   TextField(
          //                                     maxLines: 3,
          //                                     decoration: const InputDecoration(
          //                                         labelText: 'Description'),
          //                                     controller:
          //                                         updateDescriptionController,
          //                                   ),
          //                                 ],
          //                               );
          //                             } else {
          //                               return const Center(
          //                                 child: CircularProgressIndicator(),
          //                               );
          //                             }
          //                           },
          //                         ),
          //                         actions: [
          //                           ElevatedButton(
          //                             onPressed: () {
          //                               Navigator.pop(context);
          //                             },
          //                             child: const Text('Cancel'),
          //                           ),
          //                           const SizedBox(
          //                             width: 4,
          //                           ),
          //                           BlocListener<EditProductBloc,
          //                               EditProductState>(
          //                             listener: (context, state) {
          //                               if (state is EditProductLoaded) {
          //                                 updateTitleController.clear();
          //                                 updatePriceController.clear();
          //                                 updateDescriptionController.clear();
          //                                 ScaffoldMessenger.of(context)
          //                                     .showSnackBar(const SnackBar(
          //                                         content: Text('xxx')));
          //                                 Navigator.pop(context);
          //                                 context
          //                                     .read<GetAllProductBloc>()
          //                                     .add(DoGetAllProductEvent());
          //                               }
          //                             },
          //                             child: BlocBuilder<EditProductBloc,
          //                                 EditProductState>(
          //                               builder: (context, state) {
          //                                 if (state is EditProductLoading) {
          //                                   return const Center(
          //                                     child:
          //                                         CircularProgressIndicator(),
          //                                   );
          //                                 }
          //                                 return ElevatedButton(
          //                                   onPressed: () {
          //                                     final productModel =
          //                                         ProductModelUpdate(
          //                                       title:
          //                                           updateTitleController.text,
          //                                       price: int.parse(
          //                                           updatePriceController.text),
          //                                       description:
          //                                           updateDescriptionController
          //                                               .text,
          //                                     );

          //                                     context
          //                                         .read<EditProductBloc>()
          //                                         .add(DoUpdateProductEvent(
          //                                             productModel:
          //                                                 productModel,
          //                                             id: product.id!));

          //                                     // context
          //                                     //     .read<GetAllProductBloc>()
          //                                     //     .add(DoGetAllProductEvent());
          //                                   },
          //                                   child: const Text('Save'),
          //                                 );
          //                               },
          //                             ),
          //                           ),
          //                         ],
          //                       );
          //                     },
          //                   );
          //                 },
          //                 child: Card(
          //                   child: ListTile(
          //                     leading:
          //                         CircleAvatar(child: Text('${product.price}')),
          //                     title: Text(product.title ?? '-'),
          //                     subtitle: Text(product.description ?? '-'),
          //                   ),
          //                 ),
          //               );
          //             }));
          //       }
          //       return const Text('no data');
          //     },
          //   ),
          // ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context
                    .read<GetProductPaginationBloc>()
                    .add(GetProductPaginationStarted());
              },
              child: BlocListener<GetProductPaginationBloc,
                  GetProductPaginationLoaded>(
                listener: (context, state) {
                  if (state.status == Status.loading) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Loading More...')));
                  }
                },
                child: BlocBuilder<GetProductPaginationBloc,
                    GetProductPaginationLoaded>(
                  builder: (context, state) {
                    if (state.status == Status.initial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state.status == Status.loaded) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      product = state.products!;
                      return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          controller: controller,
                          itemCount: product.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.read<GetOneProductBloc>().add(
                                    DoGetOneProductEvent(
                                        id: product[index].id!));
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Edit Product'),
                                      content: BlocBuilder<GetOneProductBloc,
                                          GetOneProductState>(
                                        builder: (context, state) {
                                          if (state is GetOneProductLoaded) {
                                            updateTitleController.text =
                                                state.product.title!;
                                            updatePriceController.text =
                                                state.product.price.toString();
                                            updateDescriptionController.text =
                                                state.product.description!;
                                            return DialogWidget(
                                                titleController:
                                                    updateTitleController,
                                                priceController:
                                                    updatePriceController,
                                                descriptionController:
                                                    updateDescriptionController);
                                          } else {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
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
                                        BlocListener<EditProductBloc,
                                            EditProductState>(
                                          listener: (context, state) {
                                            if (state is EditProductLoaded) {
                                              updateTitleController.clear();
                                              updatePriceController.clear();
                                              updateDescriptionController
                                                  .clear();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text('xxx')));
                                              Navigator.pop(context);
                                              // context
                                              //     .read<GetAllProductBloc>()
                                              //     .add(DoGetAllProductEvent());
                                              context
                                                  .read<
                                                      GetProductPaginationBloc>()
                                                  .add(
                                                      GetProductPaginationStarted());
                                            }
                                          },
                                          child: BlocBuilder<EditProductBloc,
                                              EditProductState>(
                                            builder: (context, state) {
                                              if (state is EditProductLoading) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              return ElevatedButton(
                                                onPressed: () {
                                                  final productModel =
                                                      ProductModelUpdate(
                                                    title: updateTitleController
                                                        .text,
                                                    price: int.parse(
                                                        updatePriceController
                                                            .text),
                                                    description:
                                                        updateDescriptionController
                                                            .text,
                                                  );

                                                  context
                                                      .read<EditProductBloc>()
                                                      .add(DoUpdateProductEvent(
                                                          productModel:
                                                              productModel,
                                                          id: product[index]
                                                              .id!));

                                                  // context
                                                  //     .read<GetAllProductBloc>()
                                                  //     .add(DoGetAllProductEvent());
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
                              // child: Card(
                              //   child: ListTile(
                              //     leading: CircleAvatar(
                              //         child: Text('${product[index].price}')),
                              //     title: Text(product[index].title ?? '-'),
                              //     subtitle:
                              //         Text(product[index].description ?? '-'),
                              //   ),
                              // ),
                              child: CardWidget(data: product[index]),
                            );
                          }));
                    }
                    return const Text('no data');
                  },
                ),
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
                        context
                            .read<GetProductPaginationBloc>()
                            .add(GetProductPaginationStarted());
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

                            // context
                            //     .read<GetAllProductBloc>()
                            //     .add(DoGetAllProductEvent());
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
}
