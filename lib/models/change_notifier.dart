

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Collection with ChangeNotifier {
  List<Items> _items = [
    Items(name: "a", favourite: true),
    Items(name: "b", favourite: true),
    Items(name: "c", favourite: true),
  ];

List widgetData =[];
 void itemdata() {

 }

  List<Items> get favItems =>
      [..._items].where((element) => element.favourite == true).toList();

  toggleFavourite(Items item) {
    int index = _items.indexWhere((element) => element.name == item.name);
    _items[index].favourite = !_items[index].favourite;
    notifyListeners();
  }
}

class Items { //simple Model class
   String name;
  bool favourite;
  

  Items({required this.name,required  this.favourite});
}
class MyDemo extends StatelessWidget {
  const MyDemo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Collection(),
      builder: (context, child) => MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _list = context.select((Collection list) => list.favItems); 
    //to update only if list is different

    return  Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (_, index) => CardWidget(_list[index])
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final Items _item;

  CardWidget(this._item);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Text(_item.name),
          IconButton(
              icon:
                  _item.favourite ? Icon(Icons.star) : Icon(Icons.star_border),
              onPressed: () {
                Provider.of<Collection>(context, listen: false).toggleFavourite(_item);
              })
        ],
      ),
    );
  }
}



class carType extends ChangeNotifier {

  final List _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => _items.length * 42;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Step item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}




class Person with ChangeNotifier {
  Person({required this.name,required this.age});

  final String name;
  int age;

  void increaseAge() {
    this.age++;
    notifyListeners();
  }
}


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return     ChangeNotifierProvider(
//       create: (_) => Person(name: "Yohan", age: 25),
//       child:  Scaffold(
//       appBar: AppBar(
//         title: const Text('Provider Class'),
//       ),
//       body: Center(
//         child: Text(
//           '''
//           Hi ${context.select((Person p) => p.name)}!
//           You are ${Provider.of<Person>(context).age} years old''',
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Provider.of<Person>(context, listen: false).increaseAge(),
//       ),
//       )
//     );
//   }
// }
