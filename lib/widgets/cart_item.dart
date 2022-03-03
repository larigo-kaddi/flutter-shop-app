

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItems extends StatelessWidget {
   final String id;
   final String productId;
   final String title;
   final double price;
   final int quantity;

   CartItems(this.id,this.productId, this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete, 
          color: Colors.white,
           size: 40,
           ),
           alignment: Alignment.centerRight,
           padding: EdgeInsets.only(right: 20),
           margin: EdgeInsets.symmetric(
             horizontal: 15,
             vertical: 4,
           ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
           return  showDialog(
              context: context,
               builder: (ctx)=> AlertDialog(
                 title: Text('Are you sure?'),
                 content: Text('Do you want to remove the Item from the cart?'),
                 actions: <Widget>[
                   TextButton(
                     child: Text('No'),
                     onPressed: (){ 
                       Navigator.of(ctx).pop(false);
                       },),
                   TextButton(
                     child: Text('Yes'),
                     onPressed: (){
                               Navigator.of(ctx).pop(true);
                     },
                      ),
                 ],
               ),
               );
      },
      onDismissed: (direction){
              Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
           margin: EdgeInsets.symmetric(
             horizontal: 15,
             vertical: 4,
           ),
           child: Padding(
             padding: EdgeInsets.all(8),
             child: ListTile(
               leading: CircleAvatar(
                 maxRadius: 40,
                 backgroundColor: Theme.of(context).primaryColor,
                 child: Padding(
                   padding: const EdgeInsets.all(2.0),
                   child: FittedBox(
                     child: Text('\$$price', style: TextStyle(color:Colors.white),),
                     ),
                 ),
                 
                 ),
                 title: Text(title),
                 subtitle: Text('Total \$${(price*quantity)}'),
                 trailing: Text('\$$quantity x'),
             ), 
             ),
      ),
    );
  }
}