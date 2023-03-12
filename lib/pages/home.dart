import 'dart:io';

import 'package:band_names/models/band_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BandModel> bands = [
    BandModel(id: "1", name: "Metalica", votes: 5),
    BandModel(id: "2", name: "Jon bobi", votes: 1),
    BandModel(id: "3", name: "tdg", votes: 3),
    BandModel(id: "4", name: "slipknot", votes: 6),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Band names",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) {
          return _BandTile(
            band: bands[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: Icon(Icons.add),
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("new band name:"),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text),
                child: Text("Add"),
              )
            ],
          );
        },
      );
    }

    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("New band name"),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("add"),
                onPressed: () => addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text("Dismiss"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }

  void addBandToList(String name) {
    if (name.isNotEmpty) {
      setState(() {
        bands.add(BandModel(id: DateTime.now().toString(),name: name,votes: 0));
      });
    }
    Navigator.pop(context);
  }
}

class _BandTile extends StatelessWidget {
  final BandModel band;

  const _BandTile({required this.band});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        print(direction);
        
      },
      background: Container(
        padding: EdgeInsets.only(left: 10),
        color: Colors.red,
        child:Align(
          alignment: Alignment.centerLeft,
          child: Text("Delete Band",style: TextStyle(color: Colors.white),)) ,),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name!.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name!),
        trailing: Text(
          "${band.votes}",
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }
}
