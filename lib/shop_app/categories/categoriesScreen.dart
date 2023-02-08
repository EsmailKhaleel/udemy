// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/components/components.dart';
import 'package:tutorial_app/shop_app/cubit/cubit.dart';
import 'package:tutorial_app/shop_app/cubit/states.dart';
import 'package:tutorial_app/shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var catModel = ShopCubit.get(context).categoriesModel;
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildCatItem(catModel!.data!.data![index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: catModel!.data!.data!.length,
            );
          },
    );
        }
  
  

  Widget buildCatItem(DataModel? dataModel) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                dataModel!.image!,
              ),
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              dataModel.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );
}
