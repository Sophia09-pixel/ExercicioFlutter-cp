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
                    Navigator.pop(context);
                  },
                  child: Text("data"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
