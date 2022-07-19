import 'package:flutter/material.dart';

enum Direction { TOP, BOTTOM, LEFT, RIGHT }

Direction direction = Direction.TOP;
bool isAdded = false;
double topLeftRight = 0;
double topLeftBottom = 0;
double bottomRightTop = 0;
double bottomLeftRight = 0;
List<Widget> widgetsTop = [];
List<Widget> widgetsBottom = [];
List<Widget> widgetsLeft = [];
List<Widget> widgetsRight = [];

List<String> players = ['Gianluca', 'Victor', 'Lucas'];

class ListWidgets extends StatefulWidget {
  const ListWidgets({Key? key}) : super(key: key);

  @override
  State<ListWidgets> createState() => _ListWidgetsState();
}

class _ListWidgetsState extends State<ListWidgets> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadPlayers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.width * 0.3,
          width: MediaQuery.of(context).size.width * 0.53,
          child: Stack(
            children: <Widget>[
              Stack(children: widgetsTop),
              Stack(children: widgetsLeft),
              Stack(children: widgetsRight),
              Stack(children: widgetsBottom),
              Positioned(
                  top: MediaQuery.of(context).size.width * 0.10,
                  left: MediaQuery.of(context).size.width * 0.12,
                  child: buildTable())
            ],
          ),
        ),
      ),
    );
  }

  void loadPlayers() {
    players.forEach((element) {
      addPlayer('PP', element);
    });
  }

  void addPlayer(String vote, String name) {
    buildTop("PP", name);
    if (isAdded) {
      isAdded = false;
      return;
    }
    buildLeft("P", name);
    if (isAdded) {
      isAdded = false;
      return;
    }
    buildRight("M", name);
    if (isAdded) {
      isAdded = false;
      return;
    }
    buildBottom("G", name);
    isAdded = false;
  }

  void buildTop(String vote, String nome) {
    if (widgetsTop.length >= 8) return;
    if (direction == Direction.TOP) {
      var p = Positioned(
        right: topLeftRight += 100.00,
        child: buildCard(vote, nome),
      );
      widgetsTop.add(p);
      direction = Direction.BOTTOM;
      isAdded = true;
      super.setState(() {});
    }
  }

  void buildLeft(String vote, String nome) {
    if (direction == Direction.LEFT) {
      widgetsLeft.add(Positioned(
        top: topLeftBottom += 125.00,
        child: buildCard(vote, nome),
      ));
      direction = widgetsRight.length < 3 ? Direction.RIGHT : Direction.BOTTOM;
      isAdded = true;
      super.setState(() {});
    }
  }

  void buildRight(String vote, String name) {
    if (direction == Direction.RIGHT) {
      widgetsRight.add(Positioned(
        left: MediaQuery.of(context).size.width * 0.47,
        top: bottomRightTop += 125.00,
        child: buildCard(vote, name),
      ));
      super.setState(() {});
      direction = Direction.TOP;
      isAdded = true;
    }
  }

  void buildBottom(String vote, String name) {
    if (widgetsBottom.length >= 8) return;
    if (direction == Direction.BOTTOM) {
      widgetsBottom.add(Positioned(
        top: MediaQuery.of(context).size.width * 0.24,
        left: bottomLeftRight += 100.00,
        child: buildCard(vote, name),
      ));
      isAdded = true;
      direction = widgetsLeft.length < 3 ? Direction.LEFT : Direction.TOP;
      super.setState(() {});
    }
  }

  Widget buildCard(String vote, String name) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 45,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                vote,
                textScaleFactor: 1.5,
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Text(
          name,
          textScaleFactor: 1.5,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget buildTable() {
    return Container(
        width: 550,
        height: 200,
        decoration: BoxDecoration(
          color: Color(0xffD7E9FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 150),
          child: TextButton(
            onPressed: () {
              addPlayer('PP', 'Nome');
              // loadPlayers();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Center(
                  child: Text(
                    "Add player",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
