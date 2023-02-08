// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/components/constants/constants.dart';
import 'package:tutorial_app/components/customWidget/customTextField.dart';
import 'package:tutorial_app/components/customWidget/defaultButton.dart';
import 'package:tutorial_app/shop_app/cubit/cubit.dart';
import 'package:tutorial_app/shop_app/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessGetUserDataState) {}
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        try {
          nameController.text = model!.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
        } catch (e) {
          print(e.toString());
        }

        return ConditionalBuilder(
          condition: state is! ShopLoadingGetUserDataState,
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserDataState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomTextField(
                    hint: 'Name',
                    icon: Icons.person,
                    controller: nameController,
                    label: "Name",
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    type: TextInputType.name,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomTextField(
                    hint: 'Email',
                    icon: Icons.email,
                    controller: emailController,
                    label: "Email",
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'email must not be empty';
                      }
                    },
                    type: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomTextField(
                    hint: 'Phone',
                    icon: Icons.phone,
                    controller: phoneController,
                    label: "Phone",
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                    },
                    type: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'Update',
                    onClicked: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'Logout',
                    onClicked: () {
                      signOut(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
