import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  ButtonElement submitButton = querySelector('#submitBtn') as ButtonElement;

  submitButton.onClick.listen((event) async {
    String tipoEscolhido = (querySelector('#pokemon-type') as SelectElement).value ?? '';

    if (tipoEscolhido.isEmpty) {
      querySelector('#output')!.text = 'Selecione um tipo de Pokémon';
      return;
    }

    try {
      var response = await http.get(Uri.parse('https://pokeapi.co/api/v2/type/$tipoEscolhido'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Exibe o nome do tipo escolhido
        querySelector('#type')!.text = 'Tipo escolhido: ${data['name']}';

        // Variáveis para os dados
        var doubleDamageFrom = <String>[];
        var doubleDamageTo = <String>[];
        var halfDamageFrom = <String>[];
        var halfDamageTo = <String>[];
        var noDamageFrom = <String>[];
        var noDamageTo = <String>[];

        // Processando as relações de dano
        data['damage_relations']['double_damage_from'].forEach((item) {
          doubleDamageFrom.add(item['name']);
        });
        data['damage_relations']['double_damage_to'].forEach((item) {
          doubleDamageTo.add(item['name']);
        });
        data['damage_relations']['half_damage_from'].forEach((item) {
          halfDamageFrom.add(item['name']);
        });
        data['damage_relations']['half_damage_to'].forEach((item) {
          halfDamageTo.add(item['name']);
        });
        data['damage_relations']['no_damage_from'].forEach((item) {
          noDamageFrom.add(item['name']);
        });
        data['damage_relations']['no_damage_to'].forEach((item) {
          noDamageTo.add(item['name']);
        });

        // Exibindo as informações
        querySelector('#text')!.text = '''
          double_damage_from: ${doubleDamageFrom.join(', ')}
          double_damage_to: ${doubleDamageTo.join(', ')}
          half_damage_from: ${halfDamageFrom.join(', ')}
          half_damage_to: ${halfDamageTo.join(', ')}
          no_damage_from: ${noDamageFrom.join(', ')}
          no_damage_to: ${noDamageTo.join(', ')}
        ''';
      } else {
        querySelector('#output')!.text = 'Erro ao carregar o tipo';
      }
    } catch (e) {
      querySelector('#output')!.text = 'Erro ao buscar dados';
    }
  });
}
