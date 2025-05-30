import 'package:flutter/material.dart';

class ListeAbsencePage extends StatefulWidget {
  const ListeAbsencePage({super.key});

  @override
  State<ListeAbsencePage> createState() => _ListeAbsencePageState();
}

class _ListeAbsencePageState extends State<ListeAbsencePage> {
  String? selectedPeriode = '21/05/2025 - 01/06/2025';
  String? selectedEtat = 'Justifié';

  final List<Map<String, String>> absences = [
    {'cours': 'Cours 0', 'date': '21/05/2025', 'etat': 'Justifié'},
    {'cours': 'Cours 1', 'date': '28/05/2025', 'etat': 'Non Justifié'},
    {'cours': 'Cours 2', 'date': '30/05/2025', 'etat': 'Non Justifié'},
    {'cours': 'Cours 3', 'date': '01/06/2025', 'etat': 'En Cours'},
    {'cours': 'Cours 4', 'date': '03/06/2025', 'etat': 'Justifié'},
    {'cours': 'Cours 5', 'date': '30/05/2025', 'etat': 'Non Justifié'},
    {'cours': 'Cours 6', 'date': '06/06/2025', 'etat': 'Non Justifié'},
    {'cours': 'Cours 7', 'date': '29/05/2025', 'etat': 'En Cours'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Row(
          children: [
            Icon(Icons.assignment),
            SizedBox(width: 8),
            Text("Mes Absences"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Periode", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedPeriode,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: [
                '21/05/2025 - 01/06/2025',
                '01/06/2025 - 15/06/2025'
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) => setState(() => selectedPeriode = value),
            ),
            const SizedBox(height: 16),
            const Text("Etat", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedEtat,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: ['Justifié', 'Non Justifié', 'En Cours']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => selectedEtat = value),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: absences.length,
                itemBuilder: (context, index) {
                  final absence = absences[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(absence['cours']!),
                      subtitle: Text("${absence['date']} • ${absence['etat']}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}