// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:fic4_flutter_auth_bloc/data/models/response/product/product_response_model.dart';
import 'package:intl/intl.dart';

class DetailProductPage extends StatelessWidget {
  final ProductResponseModel data;
  const DetailProductPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Widget images() {
      return SizedBox(
        width: double.infinity,
        height: height * 0.4,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.images!.length,
          itemBuilder: (context, index) {
            return Container(
              width: width - 16,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(data.images![index]),
                      fit: BoxFit.cover)),
            );
          },
        ),
      );
    }

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 24),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.deepPurple[50],
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              NumberFormat.currency(
                      locale: 'id', symbol: 'Rp. ', decimalDigits: 2)
                  .format(data.price),
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              data.title!,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      );
    }

    Widget category() {
      return Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.deepPurple[50],
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Category",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.category!.name!,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(data.category!.image!),
                            fit: BoxFit.cover)),
                  )
                ],
              ),
            ],
          ));
    }

    Widget description() {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.deepPurple[50],
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Description",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              data.description!,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      );
    }

    Widget list() {
      return Expanded(
          child: ListView(
        children: [header(), category(), description()],
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Product"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [images(), list()],
        ),
      ),
    );
  }
}
