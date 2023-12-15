import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:myproject_app/shared/bottom_nav_bar.dart';
import 'package:myproject_app/ui/cart/cart_manager.dart';
import 'package:myproject_app/ui/cart/cart_screen.dart';
import 'package:myproject_app/ui/home/home_screen.dart';
import 'package:myproject_app/ui/products/edit_product_screen.dart';
import 'package:myproject_app/ui/products/product_manager_screen.dart';
import 'package:myproject_app/ui/products/product_search.dart';
import 'package:myproject_app/ui/products/products_manager.dart';
import 'package:myproject_app/ui/users/edit_profile.dart';
import 'package:myproject_app/ui/users/user_manager.dart';

import 'ui/auth/auth_manager.dart';
import 'ui/auth/auth_screen.dart';
import 'ui/products/product_detail_screen.dart';
import 'ui/splash_screen.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UsersManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthManager(),
        ),
      ],
      child: Consumer<AuthManager>(
        builder: (context, authManager, child) {
          return MaterialApp(
            title: 'H&M',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                color: Color(
                    0xff2f2fa4), // specify the background color of the app bar
                elevation: 4, // specify the elevation of the app bar
                iconTheme: IconThemeData(color: Colors.white),
              ),
              fontFamily: 'RobotoSlab',
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.deepOrange,
              ).copyWith(
                secondary: Color(0xfff64c72),
              ),
            ),
            home: authManager.isAuth
              ? const BottomNavBar()
              : FutureBuilder(
                  future: authManager.tryAutoLogin(),
                  builder: (ctx, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const SplashScreen()
                        : const AuthScreen();
                  },
                ),
            routes: {
              CartScreen.routeName: (context) => const CartScreen(),
              ProductManagerScreen.routeName: (context) =>
                  const ProductManagerScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == ProductDetailScreen.routeName) {
                final productId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return ProductDetailScreen(
                      ctx.read<ProductsManager>().findById(productId)!,
                    );
                  },
                );
              }
              if (settings.name == ProductSearch.routeName) {
                final productName = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return ProductSearch(
                      productName
                    );
                  },
                );
              }
              if (settings.name == EditProductScreen.routeName) {
                final productId = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return EditProductScreen(
                      productId != null
                          ? ctx.read<ProductsManager>().findById(productId)
                          : null,
                    );
                  },
                );
              }
              if (settings.name == EditProfile.routeName) {
                final userId = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return EditProfile(
                      userId != null
                          ? ctx.read<UsersManager>().findById(userId)
                          : null,
                    );
                  },
                );
              }
              return null;
            },
          );
        }
      ),
    );
  }
}
