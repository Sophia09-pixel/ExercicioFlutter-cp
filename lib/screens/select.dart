import 'package:exercicio_cp/data/time_repository.dart';
import 'package:exercicio_cp/model/time.dart';
import 'package:exercicio_cp/route.dart';
import 'package:flutter/material.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  Widget build(BuildContext context) {
    final repository = TimeRepository();
    return Scaffold(
      appBar: AppBar(title: const Text("Escolha seu time")),
      body: FutureBuilder<List<Time>>(
        future: repository.fetchTime(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro aocarregar os times'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum time encontrado'));
          } else {
            // Código da construção da lista no próximoslide
            final times = snapshot.data!;
            return ListView.builder(
              itemCount: times.length,
              itemBuilder: (context, index) {
                final time = times[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, time);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Image.asset(
                            time.logo,
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              time.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
