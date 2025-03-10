import 'package:electro_shop/constants.dart';
import 'package:electro_shop/dependency_injection.dart';
import 'package:electro_shop/presentation/screens/cart_screen.dart';
import 'package:electro_shop/presentation/screens/payment_success_screen.dart';
import 'package:electro_shop/presentation/screens/product_by_category_screen.dart';
import 'package:electro_shop/presentation/screens/detail_screen.dart';
import 'package:electro_shop/presentation/screens/search_result_screen.dart';
import 'package:electro_shop/presentation/screens/search_screen.dart';
import 'package:electro_shop/presentation/screens/splash_screen.dart';
import 'package:electro_shop/presentation/utils/app_themes.dart';
import 'package:electro_shop/presentation/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = stripePublishableKey;
  DependencyInjection.config();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/search' : (context) => SearchScreen(),
            '/search-result': (context) => const SearchResultScreen(),
            '/detail': (context) => const DetailScreen(),
            '/cart': (context) => const CartScreen(),
            '/category': (context) => const ProductByCategoryScreen(),
            '/payment-success': (context) => const PaymentSuccessScreen(),
          },
        );
      },
    );
  }
}


