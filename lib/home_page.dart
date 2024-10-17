import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  resetToZero({bool resetGoal = false}) {
    setCount(_counter = 0);
    resetGoal == true ? setGoal(_goal = 0) : null;
    setTime(_time = 0);
  }

  setCount(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("counter", value);
    getCount();
  }

  setTime(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("time", value);
    getCount();
  }

  setGoal(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("goal", value);
    getCount();
  }

  setColor(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("color", value);
    getCount();
  }

  getCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt("counter") ?? 0;
      _time = prefs.getInt("time") ?? 0;
      _goal = prefs.getInt("goal") ?? 0;
      colorHex = prefs.getInt("color") ?? 0xffB1001c;
    });
  }

  @override
  void initState() {
    getCount();
    super.initState();
  }

  int rad = 0;
  int colorHex = 0xffB1001c;
  int _counter = 0;
  int _time = 0;
  int _goal = 0;
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(colorHex);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            resetToZero(resetGoal: true);
          },
          backgroundColor: mainColor,
          child: Icon(
            Icons.refresh,
          ),
        ),
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                  icon: Icon(
                      isActive ? Icons.color_lens_outlined : Icons.color_lens)),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(color: mainColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text(
                      'الهدف',
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            resetToZero();
                            setGoal(_goal - 1);
                          },
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.white,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('$_goal',
                            style:
                                TextStyle(fontSize: 28, color: Colors.white)),
                      ),
                      IconButton(
                        onPressed: () {
                          resetToZero();
                          setGoal(_goal + 1);
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          resetToZero();
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text("0"),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          resetToZero();
                          setGoal(_goal = 33);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text("33"),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          resetToZero();
                          setGoal(_goal = 100);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text("100"),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          resetToZero();
                          setGoal(_goal += 100);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text("+100"),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          resetToZero();
                          setGoal(_goal += 1000);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text("+1000"),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text('الاستغفار',
                    style: TextStyle(fontSize: 28, color: mainColor)),
                SizedBox(
                  height: 4,
                ),
                Text('$_counter',
                    style: TextStyle(fontSize: 28, color: mainColor)),
                SizedBox(
                  height: 20,
                ),
                CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 5.0,
                  percent: _counter / _goal,
                  center: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_counter >= _goal) {
                          setTime(_time + 1);
                          setCount(_counter = 1);
                        } else {
                          setCount(_counter + 1);
                        }
                      });
                    },
                    child: Icon(
                      Icons.touch_app,
                      size: 50.0,
                      color: mainColor,
                    ),
                  ),
                  backgroundColor: mainColor.withOpacity(0.2),
                  progressColor: mainColor,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('مرات التكرار : $_time',
                    style: TextStyle(fontSize: 22, color: mainColor)),
                SizedBox(
                  height: 4,
                ),
                Text('المجموع : ${_time * _goal + _counter}',
                    style: TextStyle(fontSize: 22, color: mainColor)),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                visible: isActive,
                child: Row(
                  children: [
                    Radio(
                        fillColor: WidgetStateColor.resolveWith(
                            (states) => Color(0xffB1001c)),
                        value: 0xffB1001c,
                        groupValue: colorHex,
                        onChanged: (val) {
                          setState(() {
                            setColor(val!);
                          });
                        }),
                    Radio(
                        fillColor: WidgetStateColor.resolveWith(
                            (states) => Color(0xff14212A)),
                        value: 0xff14212A,
                        groupValue: colorHex,
                        onChanged: (val) {
                          setState(() {
                            setColor(val!);
                          });
                        }),
                    Radio(
                        fillColor: WidgetStateColor.resolveWith(
                            (states) => Color(0xff62249F)),
                        value: 0xff62249F,
                        groupValue: colorHex,
                        onChanged: (val) {
                          setState(() {
                            setColor(val!);
                          });
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
