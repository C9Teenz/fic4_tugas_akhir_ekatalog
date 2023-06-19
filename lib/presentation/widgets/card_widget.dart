// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fic4_flutter_auth_bloc/data/models/response/product/product_response_model.dart';

class CardWidget extends StatelessWidget {
  final ProductResponseModel data;
  final void Function() onClick;
  const CardWidget({
    Key? key,
    required this.data,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(data.images[0]),
              ),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${data.price}',
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: onClick, icon: const Icon(Icons.edit))))
        ],
      ),
    );
  }
}
