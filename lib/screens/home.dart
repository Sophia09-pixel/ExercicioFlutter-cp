import 'package:exercicio_cp/data/setting_repository.dart';
import 'package:exercicio_cp/route.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SettingsRepository? _settingsRepository;
  @override
  void initState() {
    super.initState();
    _initRepository();
  }

  Future<void> _initRepository() async {
    final repo = await SettingsRepository.create();
    setState(() {
      _settingsRepository = repo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu time favorito"),
        actions: [
          IconButton(onPressed: _navigate, icon: Icon(Icons.arrow_right)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => {Navigator.pushNamed(context, Routes.select)},
              child: Image.asset("assets/images/Brasileirao.png", width: 150, height: 150,),
            ),
            SizedBox(),
            Center(
              child: Text(
                "Você ainda não escolheu seu time favorito, clique na imagem acima",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    final repo = await SettingsRepository.create();
    final showTimes = await repo.getTimeSelected();
    if (!mounted) return;
    if (showTimes) {
      Navigator.pushReplacementNamed(context, Routes.select);
    } else {
      Navigator.pushReplacementNamed(context, Routes.home);
    }
  }
}
