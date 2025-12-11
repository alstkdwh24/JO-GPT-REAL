import 'package:flutter/material.dart';

class DrawMenuOne extends StatefulWidget {
  const DrawMenuOne({super.key});

  @override
  State<StatefulWidget> createState() => _DrawMenuOne();
}

class _DrawMenuOne extends State<DrawMenuOne> {



  @override
  Widget build(BuildContext context) {
    var inWidth = MediaQuery.of(context).size.width * 0.8;
    var inHeight = MediaQuery.of(context).size.height;
    final orange = Color.fromRGBO(246, 234, 216, 1);
    final orangeColor = Color.fromRGBO(255, 165, 0, 1.0);
    final orangeYellow = Color.fromRGBO(244, 202, 136, 1.0);
    // TODO: implement build
    return Drawer(
      width: inWidth,
      backgroundColor: orange,
      child: ListView(
        children: [

          IconButton(
            onPressed: () {
              Navigator.pop(context); // drawer 닫기
            },
            icon: Icon(Icons.close_rounded),
          ),
          ListTile(
            leading: Icon(Icons.chat_bubble_rounded),
            title: Text("새 채팅"),
            onTap: () {
              Navigator.pop(context); // Drawer 닫기
            },
          ),
          ListTile(
            leading: Icon(Icons.library_add),
            title: Text("GPT 버전 번경"),
            onTap: () {
              Navigator.pop(context); // Drawer 닫기
            },
          ),
          Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: orangeYellow))),),
          ListTile(
         
            title: Text("새 채팅"),
            onTap: () {
              Navigator.pop(context); // Drawer 닫기
            },
          ),
        ],
      ),
    );
  }
}
