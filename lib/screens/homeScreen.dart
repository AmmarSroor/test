import 'package:flutter/material.dart';
import 'package:profiles_app/classes/weatherAPIClass.dart';
import 'package:profiles_app/widgets/customDrawer.dart';

import 'package:profiles_app/widgets/customText.dart';


class HomeScreen extends StatelessWidget {
  static final String routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.red,
          accentColor: Colors.red
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            Builder(
              builder: (innerContext)=> IconButton(
                onPressed: () async{
                  //await BlocProvider.of<AccountCubit>(context).saveLoginOnMyDevice(false);
                  Navigator.of(context).pushReplacementNamed('/');
                },
                icon: Icon(Icons.logout,color: Colors.white,),
                tooltip: 'Logout',
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Builder(
            builder: (context) => FutureBuilder(
              future: getWeather(),
              builder: (context2 ,AsyncSnapshot snapshot){
                Weather myWeather = snapshot.data as Weather;
                try{
                  return snapshot.hasData
                      ?Card(
                        elevation: 20,
                        child: Container(
                          width: 200,
                        child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text('${myWeather.name} Information',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Icon(Icons.wb_sunny,size: 100,color: Colors.yellow,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  CustomText(
                                      title:'Country',
                                      value: myWeather.sys.country=='JO'
                                          ?myWeather.sys.country+'RDAN'
                                          :myWeather.sys.country
                                  ),

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  CustomText(title:'Longitude',value: myWeather.coordinate.longitude),
                                  CustomText(title:'Latitude',value: myWeather.coordinate.latitude),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  CustomText(title:'Weather Id',value: myWeather.weather[0].id),
                                  CustomText(title:'Weather main',value: myWeather.weather[0].main),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: CustomText(title: 'Weather description',
                                  value: myWeather.weather[0].description),
                            ),
                          ],
                        ),
                    ),
                  ),
                      )
                      :Center(child: CircularProgressIndicator(),);
                }catch(e){
                  return Center(child: Text('No data Yet !',
                    style: TextStyle(fontSize: 25, color: Colors.red),),);
                }
              },
            ),
          ),
        ),
        drawer: CustomDrawer(),
      ),
    );
  }

}



