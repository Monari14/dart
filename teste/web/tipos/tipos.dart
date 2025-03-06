import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  // Captura todas as caixas de tipo
  List<Element> typeBoxes = querySelectorAll('.type-box');

  // cada div de tipos agora pode ser clicado
  for (var box in typeBoxes) {
    box.onClick.listen((event) {
      String tipoEscolhido = box.getAttribute('data-value') ?? '';

      if (tipoEscolhido.isNotEmpty) { buscarTipoPokemon(tipoEscolhido); }
    });
  }
}

Future<void> buscarTipoPokemon(String tipoEscolhido) async {
  try {
    var response = await http.get(Uri.parse('https://pokeapi.co/api/v2/type/$tipoEscolhido'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // Variáveis para os dados
      var doubleDamageFrom = <String>[];
      var doubleDamageTo = <String>[];
      var halfDamageFrom = <String>[];
      var halfDamageTo = <String>[];
      var noDamageFrom = <String>[];
      var noDamageTo = <String>[];
      
      // Processando as relações de dano
      data['damage_relations']['double_damage_from'].forEach((item) { doubleDamageFrom.add(item['name']); });
      data['damage_relations']['double_damage_to'].forEach((item) { doubleDamageTo.add(item['name']); });
      data['damage_relations']['half_damage_from'].forEach((item) { halfDamageFrom.add(item['name']); });
      data['damage_relations']['half_damage_to'].forEach((item) { halfDamageTo.add(item['name']); });
      data['damage_relations']['no_damage_from'].forEach((item) { noDamageFrom.add(item['name']); });
      data['damage_relations']['no_damage_to'].forEach((item) { noDamageTo.add(item['name']); });

      // Exibindo as informações
      querySelector('#output')!.setInnerHtml('''
        <div class="damage-container">
        <h1>Tipo escolhido: ${data['name']}</h1>
          <div>
            <h2>Toma x2 de:</h2>
            <div class="damage-types">${doubleDamageFrom.map((t) => '<div class="type-box ${t.toLowerCase()}">$t</div>').join('')}</div>
          </div>
          <div>
            <h2>Da x2 em:</h2>
            <div class="damage-types">${doubleDamageTo.map((t) => '<div class="type-box ${t.toLowerCase()}">$t</div>').join('')}</div>
          </div>
          <div>
            <h2>Toma neutro de:</h2>
            <div class="damage-types">${halfDamageFrom.map((t) => '<div class="type-box ${t.toLowerCase()}">$t</div>').join('')}</div>
          </div>
          <div>
            <h2>Da neutro em:</h2>
            <div class="damage-types">${halfDamageTo.map((t) => '<div class="type-box ${t.toLowerCase()}">$t</div>').join('')}</div>
          </div>
          <div>
            <h2>Não toma dano de:</h2>
            <div class="damage-types">${noDamageFrom.map((t) => '<div class="type-box ${t.toLowerCase()}">$t</div>').join('')}</div>
          </div>
          <div>
            <h2>Não da dano em:</h2>
            <div class="damage-types">${noDamageTo.map((t) => '<div class="type-box ${t.toLowerCase()}">$t</div>').join('')}</div>
          </div>
        </div>
      ''', treeSanitizer: NodeTreeSanitizer.trusted);

    } else {
      querySelector('#output')!.setInnerHtml('''
        <div class="damage-container">
        </div>
      ''', treeSanitizer: NodeTreeSanitizer.trusted);    }
  } catch (e) {
    querySelector('#output')!.text = 'Erro ao buscar dados da api';
  }
}
