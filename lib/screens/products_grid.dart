import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';
import '../providers/product.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {

    var showFavs;
    
    ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
     final productData = Provider.of<Products>(context);
    final products = showFavs ? productData.favoriteItems : productData.items;
    return GridView.builder(
      padding:  const EdgeInsets.all(10),
    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
      value: products[i],
      //create: (c) => products[i],
      child: ProductItem(
),
    ),
    itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3/2,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          ),
          );
  }
}