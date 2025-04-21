import 'package:flutter/material.dart';

class ConversorPage extends StatefulWidget {
  const ConversorPage({super.key});

  @override
  State<ConversorPage> createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    String _monedaOrigen = 'USD';
    String _monedaDestino = 'EUR';
    double _resultado = 0.0;

    final Map<String, double> tasasCambio = {
      'USD': 1.0,
      'EUR': 0.91,
      'MXN': 17.0,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Conversor de Monedas')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Cantidad'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _monedaOrigen,
                  onChanged: (valor) {
                    _monedaOrigen = valor!;
                  },
                  items: tasasCambio.keys.map((moneda) {
                    return DropdownMenuItem(
                      value: moneda,
                      child: Text(moneda),
                    );
                  }).toList(),
                ),
                const Icon(Icons.swap_horiz),
                DropdownButton<String>(
                  value: _monedaDestino,
                  onChanged: (valor) {
                    _monedaDestino = valor!;
                  },
                  items: tasasCambio.keys.map((moneda) {
                    return DropdownMenuItem(
                      value: moneda,
                      child: Text(moneda),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double cantidad = double.tryParse(_controller.text) ?? 0;
                double tasaOrigen = tasasCambio[_monedaOrigen]!;
                double tasaDestino = tasasCambio[_monedaDestino]!;
                double resultado = cantidad * (tasaDestino / tasaOrigen);

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text('Resultado: ${resultado.toStringAsFixed(2)} $_monedaDestino'),
                  ),
                );
              },
              child: const Text('Convertir'),
            ),
          ],//
        ),
      ),
    );
  }

}
