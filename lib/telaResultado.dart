import 'package:flutter/material.dart';

String _formatarNumero(double valor, {int casas = 2}) {
  return valor.toStringAsFixed(casas).replaceAll('.', ',');
}

class TelaResultadoCusto extends StatelessWidget {
  final double distancia;
  final double precoCombustivel;
  final double consumo;

  const TelaResultadoCusto({
    super.key,
    required this.distancia,
    required this.precoCombustivel,
    required this.consumo,
  });

  @override
  Widget build(BuildContext context) {
    final litrosNecessarios = distancia / consumo;
    final custoTotal = litrosNecessarios * precoCombustivel;

    return _TelaResultado(
      titulo: 'Resultado do custo',
      icone: Icons.attach_money,
      destaque: 'R\$ ${_formatarNumero(custoTotal)}',
      descricao: 'Este é o custo estimado de combustível para a viagem.',
      detalhes: [
        'Distância: ${_formatarNumero(distancia)} km',
        'Combustível necessário: ${_formatarNumero(litrosNecessarios)} L',
        'Preço do combustível: R\$ ${_formatarNumero(precoCombustivel)} / L',
      ],
    );
  }
}

class TelaResultadoTempo extends StatelessWidget {
  final double distancia;
  final double velocidadeMedia;

  const TelaResultadoTempo({
    super.key,
    required this.distancia,
    required this.velocidadeMedia,
  });

  @override
  Widget build(BuildContext context) {
    final tempoEmHoras = distancia / velocidadeMedia;
    final totalMinutos = (tempoEmHoras * 60).round();
    final horas = totalMinutos ~/ 60;
    final minutos = totalMinutos % 60;
    final resultado = horas > 0
        ? '$horas h ${minutos.toString().padLeft(2, '0')} min'
        : '$minutos min';

    return _TelaResultado(
      titulo: 'Resultado do tempo',
      icone: Icons.timer_outlined,
      destaque: resultado,
      descricao: 'Este é o tempo estimado para concluir a viagem.',
      detalhes: [
        'Distância: ${_formatarNumero(distancia)} km',
        'Velocidade média: ${_formatarNumero(velocidadeMedia)} km/h',
        'Tempo em horas: ${_formatarNumero(tempoEmHoras)} h',
      ],
    );
  }
}

class _TelaResultado extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final String destaque;
  final String descricao;
  final List<String> detalhes;

  const _TelaResultado({
    required this.titulo,
    required this.icone,
    required this.destaque,
    required this.descricao,
    required this.detalhes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text(titulo),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icone, color: Colors.blue, size: 70),
                const SizedBox(height: 16),
                Text(
                  'Resultado calculado',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 28,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Text(
                        destaque,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        descricao,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detalhes do cálculo',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        for (final detalhe in detalhes) ...[
                          Text(detalhe, style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Voltar e alterar dados'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
