import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postmanapihackathon/Weather/Services/searchButton.dart';
import '../Models/weather.dart';

class FetchScreen extends StatefulWidget {
  double? lat ;
  double? long ;
  AsyncSnapshot<WeatherData>? snapshot;
  FetchScreen({this.lat, this.long, this.snapshot});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  final day=["Today","Tuesday","Wednesday"];
  final temp= [14.5,28.0,16.0,15.2,35.1,18.4,19.0,42.3,21.3];

  @override
  Widget build(BuildContext context) {
    print(widget.snapshot);
    var height= MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextStyle titlefont= TextStyle(fontWeight: FontWeight.w600, fontSize: width*0.055);
    TextStyle infofont= TextStyle(fontWeight: FontWeight.w400, fontSize: width*0.053,color: Colors.grey);



    return Center(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Expanded(child: SearchButton()),


            SizedBox(
              height: height*0.03,
            ),
            Icon(
              Icons.water_drop,
              color: Colors.blue,
              size: height*0.1,
            ),

            SizedBox(
              height: height*0.01,
            ),
            Text((((widget.snapshot!.data!.main!.temp)!-273).round().toString())+" °C",style: TextStyle(fontWeight: FontWeight.w400,fontSize: width*0.16),),
            Text(widget.snapshot!.data!.name.toString(), style: TextStyle(fontSize: width*0.06,color:Colors.grey ),),

            SizedBox(height: height*0.03,),

            //SizedBox(height: height*0.02),
            Container(

              height: height*0.2,
              width: width*0.9,
              child: ListView.builder(
                  itemCount: temp.length,
                  scrollDirection: Axis.horizontal,

                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right:5.0),
                      child: Card(
                        elevation: 05.0,
                        color: Colors.transparent,
                        child: Container(


                          child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height*0.03,
                                  ),
                                  Text(day[(index/3).floor()],
                                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: width*0.053,color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: height*0.01,
                                  ),
                                  Icon(
                                    Icons.water_drop,
                                    color: Colors.blue,
                                    size: height*0.05,
                                  ),
                                  SizedBox(
                                    height: height*0.01,
                                  ),
                                  Text(temp[index].round().toString(),
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: width*0.053,color: Colors.white),
                                ),
                                ],
                              )
                          ),

                          //height: height*0.13
                          decoration: new BoxDecoration(
                            color: concolor(temp[index]),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),

                          ),
                          width: width * 0.3,
                        ),
                      ),
                    );

                  }

              ),
            ),
            SizedBox(height: height*0.06),
            Align(
              child: Padding(
                padding:  EdgeInsets.only(left:width*0.05),
                child: Text("Additional Information",
                  style: TextStyle(fontSize: width*0.06,color: Colors.black54, fontWeight: FontWeight.w800),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            Divider(
              thickness: height*0.001,
              color: Colors.grey,
            ),
            SizedBox(
              height: height*0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width*0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Visibility', style: titlefont,),
                      SizedBox(
                        height: height*0.01,
                      ),
                      Text('Pressure', style: titlefont,),
                      SizedBox(
                        height: height*0.01,
                      ),
                      Text('Min Temp', style: titlefont,)
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width*0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(((widget.snapshot!.data!.visibility)!/1000).toString()+" KM", style: infofont,),
                      SizedBox(
                        height: height*0.01,
                      ),
                      Text(widget.snapshot!.data!.main!.pressure.toString(), style: infofont,),
                      SizedBox(
                        height: height*0.01,
                      ),
                      Text(widget.snapshot!.data!.main!.tempMin.toString(), style: infofont,)
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width*0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Humidity', style: titlefont,),
                      SizedBox(
                        height: height*0.01,
                      ),
                      Text('Feels Like', style: titlefont,),
                      SizedBox(
                        height: height*0.01,
                      ),
                      Text('Max Temp', style: titlefont,)
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width*0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(widget.snapshot!.data!.main!.humidity.toString()+"%", style: infofont,),
                      SizedBox(
                        height: height*0.01,
                      ),
                      Text(widget.snapshot!.data!.main!.feelsLike.toString(), style: infofont,),
                      SizedBox(
                        height: height*0.01,
                      ),
                      Text(widget.snapshot!.data!.main!.tempMax.toString(), style: infofont,)
                    ],
                  ),
                ),
              ],

            )

          ],
        )
    );


  }
}
Color concolor(double a)
{
  final container_color=[Color.fromRGBO(0, 0, 139, 0.7),Colors.lightBlue,Colors.amber,Colors.orange,Colors.deepOrange,Colors.red];
  int i;
  if(a<15.0)
  {
    i=0;
  }
  else if(a>=15.0 && a<20.0)
  {
    i=1;
  }
  else if(a>=20.0 && a<25.0)
  {
    i=2;
  }
  else if(a>=25.0 && a<30.0)
  {
    i=3;
  }
  else if(a>=30.0 && a<35)
  {
    i=4;
  }
  else
  {
    i=5;
  }
  return container_color[i];
}
