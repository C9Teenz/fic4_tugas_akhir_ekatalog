// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fic4_flutter_auth_bloc/data/datasources/product_datasources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../cubit/product/products_pagination/products_pagination_cubit.dart';
import '../../cubit/product/update_product/update_product_cubit.dart';
import '../../data/models/request/product_model.dart';
import '../../data/models/response/product/product_response_model.dart';
import 'camera_page.dart';

class UpdateProductPage extends StatefulWidget {
  final ProductResponseModel data;
  const UpdateProductPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? descriptionController;

  XFile? picture;

  List<XFile>? multiplePicture;

  void takePicture(XFile file) {
    picture = file;
    setState(() {});
  }

  void takeMultiplePicture(List<XFile> files) {
    multiplePicture = files;
    setState(() {});
  }

  @override
  void initState() {
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (photo != null) {
      picture = photo;
      setState(() {});
    }
  }

  Future<void> getMultipleImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> photo = await picker.pickMultiImage();

    multiplePicture = photo;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    titleController!.text = widget.data.title;
    priceController!.text = widget.data.price.toString();
    descriptionController!.text = widget.data.description;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            picture != null
                ? SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.file(File(picture!.path)))
                : Row(
                    children: [
                      ...widget.data.images
                          .map((e) => SizedBox(
                              height: 120,
                              width: 120,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Image.network(e),
                              )))
                          .toList()
                    ],
                  ),
            const SizedBox(
              height: 8,
            ),
            multiplePicture != null
                ? Row(
                    children: [
                      ...multiplePicture!
                          .map((e) => SizedBox(
                              height: 120,
                              width: 120,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Image.file(File(e.path)),
                              )))
                          .toList()
                    ],
                  )
                : SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () async {
                      await availableCameras().then((value) => Navigator.push(
                              context, MaterialPageRoute(builder: (_) {
                            return CameraPage(
                              takePicture: takePicture,
                              cameras: value,
                            );
                          })));
                      // getImage(ImageSource.camera);
                    },
                    child: const Text('Camera')),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                    // getMultipleImage();
                  },
                  child: const Text(
                    "Galery",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(
              height: 16,
            ),
            BlocListener<UpdateProductCubit, UpdateProductState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  loaded: (model) {
                    debugPrint(model.toString());
                    context.read<ProductsPaginationCubit>().getProduct();
                    Navigator.pop(context);
                  },
                );
              },
              child: BlocBuilder<UpdateProductCubit, UpdateProductState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return ElevatedButton(
                        onPressed: () async {
                          final product = widget.data;
                          if (titleController!.text == product.title &&
                              priceController!.text ==
                                  product.price.toString() &&
                              descriptionController!.text ==
                                  product.description &&
                              picture == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Pastikan terdapat data yang dirubah")));
                          } else {
                            if (picture != null) {
                              final image =
                                  await ProductDatasources.uploadImage(
                                      picture!);
                              image.fold((l) => null, (r) {
                                final model = ProductModel(
                                    title: titleController!.text,
                                    price: int.parse(priceController!.text),
                                    description: descriptionController!.text,
                                    images: [r.location]);
                                context
                                    .read<UpdateProductCubit>()
                                    .updateProduct(model, widget.data.id);
                              });
                            } else {
                              final model = ProductModel(
                                  title: titleController!.text,
                                  price: int.parse(priceController!.text),
                                  description: descriptionController!.text,
                                  images: widget.data.images);
                              context
                                  .read<UpdateProductCubit>()
                                  .updateProduct(model, widget.data.id);
                            }

                            // final model = ProductModel(
                            //     title: titleController!.text,
                            //     price: int.parse(priceController!.text),
                            //     description: descriptionController!.text);
                            // context
                            //     .read<UpdateProductCubit>()
                            //     .updateProduct(model, widget.data.id);
                          }
                        },
                        // style: ElevatedButton.styleFrom(
                        //   backgroundColor: context.theme.appColors.primary,
                        // ),
                        child: const Text('Submit'),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
