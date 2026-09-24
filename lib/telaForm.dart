import 'package:flutter/material.dart';
import 'package:projetomilleage/telaResultado.dart';

class TelaForm extends StatefulWidget {
  const TelaForm({super.key});

  @override
  State<TelaForm> createState() => _TelaFormState();
}

class _TelaFormState extends State<TelaForm> {
  final TextEditingController controllerDistancia = TextEditingController();
  final TextEditingController controllerPrecoComb = TextEditingController();
  final TextEditingController controllerConsumo = TextEditingController();
  final TextEditingController controllerVelMedia = TextEditingController();

  @override
  void dispose() {
    controllerDistancia.dispose();
    controllerPrecoComb.dispose();
    controllerConsumo.dispose();
    controllerVelMedia.dispose();
    super.dispose();
  }

  double? _converterNumero(String valor) {
    final numero = valor.trim().replaceAll(',', '.');
    return double.tryParse(numero);
  }

  bool _validarCampos() {
    final distancia = _converterNumero(controllerDistancia.text);
    final preco = _converterNumero(controllerPrecoComb.text);
    final consumo = _converterNumero(controllerConsumo.text);
    final velocidade = _converterNumero(controllerVelMedia.text);

    if (distancia == null || distancia <= 0 ||
        preco == null || preco <= 0 ||
        consumo == null || consumo <= 0 ||
        velocidade == null || velocidade <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos com valores maiores que zero.'),
        ),
      );
      return false;
    }
    return true;
  }

  void _calcularCusto() {
    if (!_validarCampos()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TelaResultadoCusto(
          distancia: _converterNumero(controllerDistancia.text)!,
          precoCombustivel: _converterNumero(controllerPrecoComb.text)!,
          consumo: _converterNumero(controllerConsumo.text)!,
        ),
      ),
    );
  }

  void _calcularTempo() {
    if (!_validarCampos()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TelaResultadoTempo(
          distancia: _converterNumero(controllerDistancia.text)!,
          velocidadeMedia: _converterNumero(controllerVelMedia.text)!,
        ),
      ),
    );
  }

  InputDecoration _decoracaoCampo(String rotulo) {
    return InputDecoration(
      labelText: rotulo,
      border: const OutlineInputBorder(),
      constraints: const BoxConstraints(maxWidth: 600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text('Cálculo de Viagem'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Insira os dados abaixo e selecione um cálculo nos botões disponibilizados.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: controllerDistancia,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _decoracaoCampo('Distância da viagem (km)'),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: controllerPrecoComb,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _decoracaoCampo('Valor do combustível (R\$ / L)'),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: controllerConsumo,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _decoracaoCampo('Consumo do veículo (km/L)'),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: controllerVelMedia,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _decoracaoCampo('Velocidade média (km/h)'),
                ),
                const SizedBox(height: 30),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 18,
                  runSpacing: 12,
                  children: [
                    ElevatedButton(
                      onPressed: _calcularCusto,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Text('Calcular Custo'),
                    ),
                    ElevatedButton(
                      onPressed: _calcularTempo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Text('Calcular Tempo'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Mantém compatibilidade com o nome usado na versão original do projeto.
typedef telaForm = TelaForm;
