import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart_screen.dart';
import './screens/splash_screen.dart.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';
import './helpers/custom_route.dart';
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //it allows us to register a class to wich that you can listen in child widget 
    //and whenever that class updates, the widget which are listeneing 
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
          ),
      ChangeNotifierProxyProvider<Auth, Products>(
       update: (ctx, auth, previousProducts) => Products(
         auth.token,
         auth.userId,
           previousProducts == null ? [] : previousProducts.items,
         ),
       ), 
        ChangeNotifierProvider.value(
          value: Cart(),
          ),
           ChangeNotifierProxyProvider<Auth, Orders>(
             update: (ctx, auth, previousOrders) => Orders(
               auth.token, 
               auth.userId,
               previousOrders == null ? [] : previousOrders.orders
               ),
               ),
    ],
       // create: (context) => Products(),
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
        title: 'Myshop',
        theme: ThemeData(
         primaryColor: Colors.deepOrange,
        colorScheme: ColorScheme.fromSwatch(
               primarySwatch: Colors.deepOrange,
        ),
        fontFamily: 'Lato', 
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android :  CustomPageTransitionBuilder(),
          TargetPlatform.iOS :    CustomPageTransitionBuilder(),
        })
        ),
        home:  auth.isAuth
         ? ProductsOverviewScreen() 
         : FutureBuilder(
           future: auth.tryAutoLogin(),
           builder: (ctx, authResultSnapshot) => 
           authResultSnapshot.connectionState == 
                    ConnectionState.waiting 
                    ? SplashScreen()
          : AuthScreen(),
         ),
        routes: {
           ProductDetailScreen.routeName : (ctx) => ProductDetailScreen(),
           CartScreen.routeName: (ctx) => CartScreen(),
           OrdersScreen.routeName: (ctx) => OrdersScreen(),
           UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
           EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),),  
    );
  }
}

