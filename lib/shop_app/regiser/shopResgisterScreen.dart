// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/components/components.dart';
import 'package:tutorial_app/components/constants/constants.dart';
import 'package:tutorial_app/components/customWidget/customTextField.dart';
import 'package:tutorial_app/components/customWidget/defaultButton.dart';
import 'package:tutorial_app/shop_app/regiser/cubit/cubit.dart';
import 'package:tutorial_app/shop_app/regiser/cubit/states.dart';
import 'package:tutorial_app/shop_app/shared_preferences/cache_helper.dart';
import 'package:tutorial_app/shop_app/shop_layout/shopLayout.dart';

class ShopRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.RegisterModel.status!) {
              showToast(
                text: state.RegisterModel.message!,
                state: ToastStates.SUCCESS,
              );
              CacheHelper.saveData(
                key: 'token',
                value: state.RegisterModel.data!.token,
              ).then((value) {
                token = state.RegisterModel.data!.token;
                navigateNoBack(
                  context,
                  ShopLayout(),
                );
              });
            } else {
              showToast(
                text: state.RegisterModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register'.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Register now to get awesome offers'.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hint: 'Name',
                          icon: Icons.person,
                          controller: nameController,
                          label: 'Enter Your Name',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                          },
                          type: TextInputType.name,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hint: 'Phone',
                          icon: Icons.phone,
                          controller: phoneController,
                          label: 'Enter Your Phone',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Phone';
                            }
                          },
                          type: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hint: 'Email',
                          icon: Icons.email_rounded,
                          controller: emailController,
                          label: 'Enter Your Email',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email';
                            }
                          },
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hint: 'Password',
                          icon: Icons.lock_outlined,
                          controller: passwordController,
                          label: 'Enter Your Password',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                          },
                          type: TextInputType.visiblePassword,
                          Suffix: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVissibility();
                          },
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          // condition: state is! ShopRegisterLoadingState,
                          condition: true,
                          builder: (context) => defaultButton(
                            text: 'Register',
                            onClicked: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Do have an account'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              child: Text(
                                'Sign In'.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
