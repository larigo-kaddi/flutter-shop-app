
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import '../screens/products_grid.dart';
import '../providers/products.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions{
  Favorites,
  All,
}



class ProductsOverviewScreen extends StatefulWidget {
  
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {

  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
 // The first way to fetsh data from the internet using the Helper Constructor Future.Delayed 
  @override 
   void initState(){
     //Provider.of<Products>(context).fetchAndSetProducts();
      // Future.delayed(Duration.zero).then((_){
           //Provider.of<Products>(context).fetchAndSetProducts();
      // });
     super.initState();
   }
@override 
void didChangeDependencies(){
    if (_isInit) {
          setState(() {
             _isLoading = true;
           });
         Provider.of<Products>(context).fetchAndSetProducts().then((_){
           setState(() {
             _isLoading = false;
           });
         });
    }
    _isInit = false;
  super.didChangeDependencies();
}
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar:   AppBar(
        title: Text('Myshop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue){
            setState(() {
               if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
             } else {
                 _showOnlyFavorites = false;
             }
            });
              },
            icon: Icon(Icons.more_vert) ,
            itemBuilder:(_)=> [
              PopupMenuItem(
                child: Text('Only Fvorites'),
                 value: FilterOptions.Favorites,
                 ),
              PopupMenuItem(
                child: Text('Show all'),
                 value: FilterOptions.All,
                 ),
            ],
             ),
             Consumer<Cart>(
               builder: (_, cart, ch) => Badge(
                 child: ch,
                   value: cart.itemCount.toString(),
                   ),
               child: IconButton(
                 icon: Icon(Icons.shopping_cart),
                 onPressed: (){
                   Navigator.of(context).pushNamed(CartScreen.routeName );
                 },
                  ),
               ), 
        ],
        
      ),
      drawer: AppDrawer(),
      body: _isLoading 
      ? Center(
        child: CircularProgressIndicator(),
      ) 
      : ProductsGrid(_showOnlyFavorites),   
    );
  }
}

