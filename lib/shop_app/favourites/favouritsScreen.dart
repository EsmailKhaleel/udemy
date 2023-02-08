// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/components/components.dart';
import 'package:tutorial_app/shop_app/cubit/cubit.dart';
import 'package:tutorial_app/shop_app/cubit/states.dart';
import 'package:tutorial_app/shop_app/models/favourites_model.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favModel = ShopCubit.get(context).favouritesModel;
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                try {
                  return buildListProductItem(
                    favModel!.data!.data![index],
                    context,
                  );
                } catch (e) {
                  print(e.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
              separatorBuilder: (context, index) => myDivider(),
              itemCount:
                  favModel!.data!.data!.length,
            ));
  }
  Widget buildListProductItem(FavouritesData? model, context) => Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      model!.product.image,
                    ),
                    width: 100,
                    height: 100,
                  ),
                  if (model.product.discount != 0)
                    Container(
                      color: Colors.red,
                      width: 100,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model.product.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.purple,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          if (model.product.discount != 0)
                            Text(
                              '${model.product.oldPrice}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              // print(model.id);
                              // ShopCubit.get(context).changeFavourites(model.product!.id);
                            },
                            icon: CircleAvatar(
                              backgroundColor: ShopCubit.get(context)
                                      .favourites[model.id]!
                                  ? Colors.purple
                                  : Colors.grey,
                              radius: 15,
                              child: Icon(
                                Icons.favorite_border_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
