import 'package:flutter/material.dart';
import 'package:masterclass_notification/src/home/controllers/home_controller.dart';
import 'package:masterclass_notification/src/home/stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeStore = HomeStore();

  late final HomeController homeController;
  late final TextEditingController timeController;

  bool masterclassEnabled = false;

  @override
  initState() {
    super.initState();
    homeController = HomeController();
    timeController = TextEditingController(text: "5");
  }

  listen(bool trigger) {
    homeController.trigger = trigger;
    homeController.startTime(int.parse(timeController.text)).listen(
      (event) {
        // print(event);
      },
    );
  }

  @override
  void dispose() {
    homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: masterclassEnabled ? Colors.teal.shade900 : Colors.black,
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: homeStore,
                builder: (context, value, child) {
                   return Text(
                      value ? "TÁ LIBERADO" : "Ainda não",
                      style: const TextStyle(fontSize: 36),
                    );
                },
              ),
              const SizedBox(height: 80),
              const Text("Tempo padrão de busca em minutos"),
              TextFormField(
                controller: timeController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
              Switch(
                value: homeController.trigger,
                onChanged: (value) {
                  if (timeController.text.isNotEmpty) {
                    homeController.trigger = value;
                    listen(value);
                    setState(() {});
                  }
                },
              ),
              const SizedBox(height: 80),
              StreamBuilder<Duration>(
                stream: homeController.time,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Duration time = snapshot.data as Duration;

                    int hour = time.inHours;
                    int minutes = time.inMinutes - (60 * (time.inMinutes ~/ 60));
                    int seconds = time.inSeconds % 60;

                    return Text(
                      "${f(hour)}:${f(minutes)}:${f(seconds)}",
                      style: const TextStyle(fontSize: 36),
                    );
                  }

                  return const Text(
                    "00:00",
                    style: TextStyle(fontSize: 36),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String f(int i){
    return i < 10 ? "0${i.toString()}" : i.toString();
  }
}
