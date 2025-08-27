import 'package:exercicio_cp/data/setting_repository.dart';
import 'package:exercicio_cp/model/time.dart';
import 'package:exercicio_cp/route.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SettingsRepository? _settingsRepository;
  Time? _selectedTime;

  @override
  void initState() {
    super.initState();
    _initRepository();
  }

  Future<void> _initRepository() async {
    final repo = await SettingsRepository.create();
    final time = await repo.getTime(); // Busca o time salvo
    setState(() {
      _settingsRepository = repo;
      _selectedTime = time;
    });
  }

  Future<void> _selectTeam() async {
    final result = await Navigator.pushNamed(context, Routes.select);
    if (result != null && result is Time) {
      await _settingsRepository?.setTime(result); // Salva o time
      setState(() {
        _selectedTime = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selectedTime;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Meu Time Favorito"),
        actions: [
          IconButton(onPressed: _selectTeam, icon: const Icon(Icons.swap_horiz)),
        ],
      ),
      body: Center(
        child: selected == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _selectTeam,
                    child: Image.asset(
                      "assets/images/Brasileirao.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Você ainda não escolheu seu time favorito,\nclique na imagem acima",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          selected.logo,
                          width: 120,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await _settingsRepository?.clear();
                            setState(() {
                              _selectedTime = null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    selected.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
