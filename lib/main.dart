import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));

}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  double num1 = 0;
  double num2 = 0;
  String action= "a";
  double result = 0;



  @override
  void dispose() {
    myController.dispose();
    myController2.dispose();
    myController3.dispose();
    super.dispose();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent[200],
        title: const Text(
          "Calculator",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
      ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.all(10.0),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:TextField(
                      controller: myController,
                      decoration: const InputDecoration(
                        hintText: 'enter num1',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly]

                  )
                ),

                TextButton(
                    onPressed: (){
                      num1 = double.parse(myController.text);
                    },
                    child: const Icon(
                      Icons.check_box
                    ))
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex :1,
                      child:TextField(

                        controller: myController2,
                        decoration: const InputDecoration(
                          hintText: 'enter operation',
                        ),

                      )
                  ),

                  TextButton(
                      onPressed: (){
                        action = myController2.text;
                      },
                      child: Icon(Icons.check_box)
                  )
                ]
            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child:TextField(
                      controller: myController3,
                      decoration: const InputDecoration(
                        hintText: 'enter num2',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly]

                  )
                ),

                TextButton(
                    onPressed: (){
                      num2 = double.parse(myController3.text);
                    },
                    child: Icon(Icons.check_box)
                )
              ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child:Text(
                        '$result',
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w100
                        ),
                      )
                  ),

                ]
            ),
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if(action == "+"){
              result = num1 + num2;
            }
            else if(action == "-"){
              result = num1 - num2;
            }
            else if(action == "*"){
              result =num1* num2;
            }
            else if(action == "/" || action == "\\"){
              result = num1 / num2;
            }
            else{
              result = num1 + num2;
            }
          });

        },
        child : const Icon(Icons.check_circle_sharp)

    ),
    );
  }
}

 