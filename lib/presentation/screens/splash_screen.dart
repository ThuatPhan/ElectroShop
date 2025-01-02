import 'package:electro_shop/presentation/bloc/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'home_screen.dart'; // Đảm bảo import đúng file HomeScreen của bạn.

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA1EEBD),
      body: BlocListener<ProductsCubit, ProductsState>(
        bloc: GetIt.instance<ProductsCubit>(),
        listener: (context, state) {
          if(state is ProductsLoadSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/shopping-cart.gif',
                height: 200,
                width: 200,
              ),
              const Text(
                'ShopDuck',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
