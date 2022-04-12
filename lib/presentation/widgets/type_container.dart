import 'package:flutter/material.dart';

class TypeContainer extends StatelessWidget {
  String type;

  TypeContainer(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: _customColor(type),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          type,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 0.5,
            color: Color(0xFFE7E7E7),
          ),
        ),
      ),
    );
  }
}

Color _customColor(String input) {
  switch (input) {
    case "Grass":
      return Colors.green;
    case "Poison":
      return Colors.deepPurple;
    case "Fire":
      return Colors.red;
    case "Flying":
      return Colors.lightBlueAccent;
    case "Water":
      return Colors.blue;
    case "Bug":
      return Colors.amber;
    case "Fairy":
      return Colors.blueGrey;
    case "Fighting":
      return Colors.redAccent;
    case "Ghost":
      return Colors.grey;
    case "Ground":
      return Colors.brown;
    case "Ice":
      return Colors.lightBlue;
    case "Psychic":
      return Colors.cyan;
    case "Rock":
      return Colors.black45;
    case "Steel":
      return Colors.indigoAccent;
    case "Electric":
      return Colors.deepOrange;
    case "Normal":
      return Colors.teal;
    default:
      return Colors.indigo;
  }
}
