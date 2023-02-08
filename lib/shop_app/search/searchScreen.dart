// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/components/customWidget/customTextField.dart';
import 'package:tutorial_app/shop_app/cubit/cubit.dart';
import 'package:tutorial_app/shop_app/models/search_model.dart';
import 'package:tutorial_app/shop_app/search/cubit/cubit.dart';
import 'package:tutorial_app/shop_app/search/cubit/states.dart';

import '../../components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                if (state is SearchLoadingState) LinearProgressIndicator(),
                SizedBox(
                  height: 10.0,
                ),
                CustomTextField(
                  hint: 'Search',
                  icon: Icons.search,
                  controller: searchController,
                  label: 'Search',
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'enter text to search';
                    }
                    return null;
                  },
                  type: TextInputType.text,
                  onSubmit: (String text) {
                    SearchCubit.get(context).search(text);
                  },
                ),
                if (state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        try {
                          return buildListProductItem(
                            SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data![index],
                            context,
                          );
                        } catch (e) {
                          print(e.toString());
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: SearchCubit.get(context)
                          .searchModel!
                          .data!
                          .data!
                          .length,
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
  Widget buildListProductItem(Data? model, context) => Padding(
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
                      model!.images!,
                    ),
                    width: 100,
                    height: 100,
                  ),
                  
                //   if (model.discount != 0)
                //     Container(
                //       color: Colors.red,
                //       width: 100,
                //       padding: EdgeInsets.symmetric(horizontal: 10),
                //       child: Text(
                //         'DISCOUNT',
                //         style: TextStyle(
                //           fontSize: 14,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                 ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name!,
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
                            '${model.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.purple,
                              fontSize: 14,
                            ),
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // if (model.discount != 0)
                          //   Text(
                          //     '${model.oldPrice}',
                          //     style: TextStyle(
                          //       fontWeight: FontWeight.w500,
                          //       color: Colors.grey,
                          //       fontSize: 12,
                          //       decoration: TextDecoration.lineThrough,
                          //     ),
                          //   ),
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
