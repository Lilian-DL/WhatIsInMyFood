import 'package:flutter/material.dart';
import 'package:whatisinmyfood/models/ingredients.dart';
import 'package:whatisinmyfood/models/products.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Products;
    return Scaffold(
      appBar: AppBar(
        // titre de la page
        title: Text(
          'Produit',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'FiraSans',
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                args.imageUrl!,
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            args.name!.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'FiraSans', fontSize: 18),
          ),
          Store(store: args.stores!),
          Expanded(child: ShowIngredient(ingredient: args.ingredients)),
          Nutriscore(nutriscore: args.nutriscore!),
        ]),
      ),
    );
  }
}

class ShowIngredient extends StatelessWidget {
  const ShowIngredient({Key? key, required this.ingredient}) : super(key: key);

  final List<Ingredients>? ingredient;

  @override
  Widget build(BuildContext context) {
    final elements = <Widget>[];
    if (ingredient != null) {
      elements.add(
        Expanded(
          child: ListView.builder(
            itemCount: ingredient!.length,
            itemBuilder: (context, position) {
              return IngredientRow(ingredient: ingredient![position]);
            },
          ),
        ),
      );
    }
    return Column(children: elements);
  }
}

class Store extends StatelessWidget {
  const Store({Key? key, required this.store}) : super(key: key);

  final String store;

  @override
  Widget build(BuildContext context) {
    if (store.length >= 1) {
      print(store.length);
      return Text("Trouvable dans ce(s) magasin(s) : " + store);
    }
    return Text("Introuvable dans nos magasins");
  }
}

class Nutriscore extends StatelessWidget {
  const Nutriscore({Key? key, required this.nutriscore}) : super(key: key);

  final String nutriscore;

  @override
  Widget build(BuildContext context) {
    if (nutriscore == "a") {
      return Image.asset(
        'assets/img/nutriscoreA.png',
        height: 150,
        width: 150,
      );
    }
    if (nutriscore == "b") {
      return Image.asset(
        'assets/img/nutriscoreB.png',
        height: 150,
        width: 150,
      );
    }
    if (nutriscore == "c") {
      return Image.asset(
        'assets/img/nutriscoreC.png',
        height: 150,
        width: 150,
      );
    }
    if (nutriscore == "d") {
      return Image.asset(
        'assets/img/nutriscoreD.png',
        height: 150,
        width: 150,
      );
    }
    if (nutriscore == "e") {
      return Image.asset(
        'assets/img/nutriscoreE.png',
        height: 150,
        width: 150,
      );
    }
    return Image.asset(
      'assets/img/nutriscoreE.png',
      height: 150,
      width: 150,
    );
  }
}

class IngredientRow extends StatelessWidget {
  const IngredientRow({Key? key, required this.ingredient}) : super(key: key);

  final Ingredients ingredient;

  @override
  Widget build(BuildContext context) {
    final elements = <Widget>[];
    if (ingredient.text != null) {
      elements.add(Text("Ingr??dient: " + ingredient.text.toString()));
    }
    if (ingredient.percent != null) {
      elements
          .add(Text("Empreinte carbone: " + Round(ingredient.percent) + "%"));
    }
    if (ingredient.vegan != null && ingredient.vegetarian != null) {
      elements.add(Column(children: const [
        Text("Cet ingr??dient est v??g??tarien !", textAlign: TextAlign.center),
        Icon(Icons.emoji_nature, color: Colors.green),
      ]));
    } else {
      elements.add(Icon(Icons.emoji_nature, color: Colors.red));
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
            side:
                BorderSide(color: Color.fromARGB(255, 247, 247, 247), width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: elements,
          ),
        ),
      ),
    );
  }

  String Round(Object? percent) {
    print(percent.runtimeType);
    if (percent.runtimeType == double) {
      return (percent as double).toStringAsFixed(2);
    }
    if (percent.runtimeType == int) {
      return percent.toString();
    }

    return percent.toString();
  }
}
