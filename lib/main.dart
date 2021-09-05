import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_climate/network_handler.dart';
import 'package:flutter_app_climate/second_screen.dart';

void main(){
  runApp(ClimateApp());
}

class ClimateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

 String? _city;

  goToSec() async {
     String res = await Navigator.of(context).push(MaterialPageRoute(
         builder: (context)=>SecondScreen()));
     setState(() {
       _city = res;
     });
 }

 @override
 void initState() {
    // TODO: implement initState
    super.initState();
    _city = 'Cairo';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset('images/fbackground.jpg',fit: BoxFit.fill,),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                        child: GestureDetector(child: Icon(Icons.home,color: Colors.white,size: 30.0),
                          onTap: (){
                            setState(() {
                              _city = 'Cairo';
                            });
                          },)
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                      child: IconButton(
                        onPressed: (){
                            goToSec();
                        },
                        icon: Icon(Icons.airplanemode_active,color: Colors.white,size: 30.0,),
                      ),
                    ),

                  ],
                ),
                Expanded(
                  child: FutureBuilder(
                      future: NetworkHandler(city: _city!).getTemp(),
                      builder: (context,AsyncSnapshot<double> snapshot){
                        if(snapshot.hasData){
                          return ListView(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height*.3,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Text('${snapshot.data!.toStringAsFixed(2)} c',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0,color: Colors.white),),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height*.1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Text('${getText(snapshot.data!)} \n in \n $_city',textAlign:TextAlign.end,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40.0,color: Colors.white),),
                              ),
                            ],
                          );
                        }
                        else{
                         return Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 3.0,));
                        }
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String getText(double temp){
    if(temp<=10){
      return 'You well need SCARF and ICE CAP';
    }
    if(temp<=17){
      return 'Bring a COAT just in case';
    }
    if(temp<=27){
      return 'Have a nice day!';
    }
    else{
      return 'It might be better to stay HOME';
    }
  }

}

