import 'package:flutter/material.dart';
class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    TextEditingController cityNameController = TextEditingController();
    return Scaffold(
        body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/therd.jpeg"),
    fit: BoxFit.cover,
    ),
    ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, size: 40, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: cityNameController,
                  decoration: InputDecoration(
                    hintText: "Enter Your City Name",
                      hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      fillColor: Colors.white,
                      labelText: "City Name",
                      filled: true,
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context, cityNameController.text);
                },
                child: Center(
                    child: Text("Get Weather",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),)),
              )
            ],
          ),
        )
    );
  }
}
