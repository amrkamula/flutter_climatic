import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController _cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _key = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children:[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset('images/sbackground.jpg',fit: BoxFit.fill,),
          ),
            ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.location_city,color: Colors.white,size: 40.0,),
                      ),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                        ),
                        child: Form(
                          key: _key = _key,
                          child: TextFormField(
                            controller: _cityController,
                            validator: (val){
                              if(val==null||val.isEmpty) return 'Please, enter a city name';
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your city name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Center(child: TextButton(
                    onPressed: (){
                      if(_key.currentState!.validate())
                      Navigator.of(context).pop(_cityController.text);
                    },
                    child: Text('Get Weather',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25.0),),
                  ),),
                ),
              ],
            )

          ]
        ),
      ),
    );
  }
}
