import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_block_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
var refreshKey =GlobalKey<RefreshIndicatorState>();

class _HomeScreenState extends State<HomeScreen> {
  
  Widget getWeatherIcon(int code) {
    switch (code) {
      case > 200 && <= 300:
        return Image(image: AssetImage("assets/images/1.png"));

      case > 300 && <= 400:
        return Image(image: AssetImage("assets/images/2.png"));

      case > 500 && <= 600:
        return Image(image: AssetImage("assets/images/3.png"));

      case > 600 && <= 700:
        return Image(image: AssetImage("assets/images/4.png"));

      case > 700 && <= 800:
        return Image(image: AssetImage("assets/images/5.png"));

      case >= 801 && < 801:
        return Image(image: AssetImage("assets/images/6.png"));

      case > 700 && <= 804:
        return Image(image: AssetImage("assets/images/7.png"));

        break;
      default:
        return Image(image: AssetImage("assets/images/1.png"));
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: () {return refreshPage(); },
      child: Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(1, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Align(
              alignment: const AlignmentDirectional(2.4, -0.5),
              child: Container(
                height: 280,
                width: 280,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepPurple),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-1.1, -0.5),
              child: Container(
                height: 280,
                width: 280,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.8, -1.2),
              child: Container(
                height: 270,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 255, 187, 0),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            BlocBuilder<WeatherBlockBloc, WeatherBlockState>(
                builder: (context, state) {
              if (state is WeatherBlockSuccess) {
                final int morning = state.weather.date!.hour;
                print(morning);
                final String morn;
                if (morning < 12) {
                  morn = "Good Morning";
                } else if (morning >= 12 || morning < 16) {
                  morn = "Good Afternoon";
                } else {
                  morn = "Good Evening";
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' ${state.weather.areaName}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            morn,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          getWeatherIcon(state.weather.weatherConditionCode!),
                          Center(
                            child: Text(
                              "${state.weather.temperature!.celsius!.round()} °C",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              "${state.weather.weatherDescription!.toUpperCase()}",
                              style: TextStyle(
                                  fontSize: 34,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Center(
                            child: Text(
                              DateFormat('EEEE dd ||')
                                  .add_jm()
                                  .format(state.weather.date!),
                              //"${state.weather.date!}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage("assets/images/11.png"),
                                    height: 70,
                                    width: 70,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Sunrise",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunrise!),
                                        //"12:28pm",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage("assets/images/12.png"),
                                    height: 70,
                                    width: 70,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Sunset",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunset!),
                                        //"4:28pm",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Divider(
                              color: Color.fromARGB(255, 87, 87, 87),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage("assets/images/13.png"),
                                    height: 70,
                                    width: 70,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Max Temp",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "${state.weather.tempMax!.celsius!.round()} °C",
                                        //"12 C",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage("assets/images/14.png"),
                                    height: 70,
                                    width: 70,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Min Temp",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "${state.weather.tempMin!.celsius!.round()} °C",

                                        //"8 C",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ]),
                  ),
                );
              } else {
                return Scaffold(
                 
                );
              }
            }),
          ]),
        ),
      ),
    ),
    );
  }

  Future<void> refreshPage() async{
    refreshKey.currentState?.show(atTop:true );
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      
    });
  }
}
