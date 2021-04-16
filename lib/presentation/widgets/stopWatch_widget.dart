import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel/data/datasources/providerRoom_datasource.dart';

import 'dart:async';

import 'customButtom_widget.dart';

class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;

  ElapsedTime({
    this.hundreds,
    this.seconds,
    this.minutes,
  });
}

class Dependencies {
  final List<ValueChanged<ElapsedTime>> timerListeners =
      <ValueChanged<ElapsedTime>>[];
  final TextStyle textStyle =
      const TextStyle(fontSize: 50.0, fontFamily: "Bebas Neue");
  final Stopwatch stopwatch = new Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}

class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);

  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  final Dependencies dependencies = new Dependencies();
  final services = ServiciosGestionCci();

  void leftButtonPressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        print("${dependencies.stopwatch.elapsed.inSeconds}");
      } else {
            _onButtonPressed(context,finishModalSheet());
      
      }
    });
  }
  void sendUpdateStatus()async{
      var milliseconds = dependencies.stopwatch.elapsedMilliseconds;
        final int hundreds = (milliseconds / 10).truncate();
        final int seconds = (hundreds / 100).truncate();
        final int minutes = (seconds / 60).truncate();

        await services.updatestatus('CLEANED', '${minutes}m ${seconds}s');
        dependencies.stopwatch.reset();
  }

  void rightButtonPressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        _onButtonPressed(context,buildModalSheet());
      } else {
        dependencies.stopwatch.start();
      }
    });
  }

  void continueButtomPressed() {
    setState(() {
      dependencies.stopwatch.start();
    });
  }

  void pauseontinueButtomPressed() {
    setState(() {
      dependencies.stopwatch.stop();
    });
  }

  void _onButtonPressed(BuildContext context, Widget widget) {
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: size.height * 0.4,
            child: Container(
              padding: EdgeInsets.all(30),
              child: widget,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30),
                  topRight: const Radius.circular(30),
                ),
              ),
            ),
          );
        });
  }

  Widget buildFloatingButton(
      String text, VoidCallback callback, List<Color> colors, IconData icon) {
    return new MyCustomButtoms(
        icon: icon, hintText: text, colors: colors, onPressed: callback);
  }

  Widget buildModalSheet() {
    return Center(
      child: new Column(
        children: [
          Text(
            'Confirm Action\n',
            style: TextStyle(fontSize: 24),
          ),
          Text(
              'The room activity will be paused.\n What would you like to do?\n',
              style: TextStyle(fontSize: 16)),
          buildFloatingButton(
              "PAUSE",
              pauseontinueButtomPressed,
              [Colors.orangeAccent[400], Colors.orangeAccent[700]],
              FontAwesomeIcons.pause),
        ],
      ),
    );
  }

  Widget finishModalSheet() {
    return Center(
      child: new Column(
        children: [
          Text(
            'Confirm Action\n',
            style: TextStyle(fontSize: 24),
          ),
          Text(
              'The room activity will be finished.\n What would you like to do?\n',
              style: TextStyle(fontSize: 16)),
          buildFloatingButton(
              "COMPLETE",
              sendUpdateStatus,
              [Colors.greenAccent[400], Colors.greenAccent[700]],
              FontAwesomeIcons.checkCircle),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
            height: 300,
            child: Card(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Text('In Progress'),
                  new TimerText(dependencies: dependencies),
                  new Text('Room 10054'),
                  new Text('individual')
                ],
              ),
            ))),
        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildFloatingButton(
                    dependencies.stopwatch.isRunning ? "PAUSE" : "CONTINUE",
                    rightButtonPressed,
                    [Colors.orangeAccent[400], Colors.orangeAccent[700]],
                    dependencies.stopwatch.isRunning
                        ? FontAwesomeIcons.pause
                        : FontAwesomeIcons.play),
                buildFloatingButton(
                    "CREATE EVENT",
                    null,
                    [Colors.yellowAccent[400], Colors.yellowAccent[700]],
                    FontAwesomeIcons.plus),
                buildFloatingButton(
                    "COMPLETE",
                    leftButtonPressed,
                    [Colors.greenAccent[400], Colors.greenAccent[700]],
                    FontAwesomeIcons.check),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TimerText extends StatefulWidget {
  TimerText({this.dependencies});
  final Dependencies dependencies;

  TimerTextState createState() =>
      new TimerTextState(dependencies: dependencies);
}

class TimerTextState extends State<TimerText> {
  TimerTextState({this.dependencies});
  final Dependencies dependencies;
  Timer timer;
  int milliseconds;

  @override
  void initState() {
    timer = new Timer.periodic(
        new Duration(milliseconds: dependencies.timerMillisecondsRefreshRate),
        callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != dependencies.stopwatch.elapsedMilliseconds) {
      milliseconds = dependencies.stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds / 10).truncate();
      final int seconds = (hundreds / 100).truncate();
      final int minutes = (seconds / 60).truncate();
      final ElapsedTime elapsedTime = new ElapsedTime(
        hundreds: hundreds,
        seconds: seconds,
        minutes: minutes,
      );
      for (final listener in dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new RepaintBoundary(
          child: new SizedBox(
            height: 60.0,
            child: new MinutesAndSeconds(dependencies: dependencies),
          ),
        ),
        new RepaintBoundary(
          child: new SizedBox(
            height: 60.0,
            child: new Hundreds(dependencies: dependencies),
          ),
        ),
      ],
    );
  }
}

class MinutesAndSeconds extends StatefulWidget {
  MinutesAndSeconds({this.dependencies});
  final Dependencies dependencies;

  MinutesAndSecondsState createState() =>
      new MinutesAndSecondsState(dependencies: dependencies);
}

class MinutesAndSecondsState extends State<MinutesAndSeconds> {
  MinutesAndSecondsState({this.dependencies});
  final Dependencies dependencies;

  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes || elapsed.seconds != seconds) {
      setState(() {
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return new Text('$minutesStr:$secondsStr.', style: dependencies.textStyle);
  }
}

class Hundreds extends StatefulWidget {
  Hundreds({this.dependencies});
  final Dependencies dependencies;

  HundredsState createState() => new HundredsState(dependencies: dependencies);
}

class HundredsState extends State<Hundreds> {
  HundredsState({this.dependencies});
  final Dependencies dependencies;

  int hundreds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hundreds != hundreds) {
      setState(() {
        hundreds = elapsed.hundreds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    return new Text(hundredsStr, style: dependencies.textStyle);
  }
}
