import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  // Seleciona o input de nome do Pokémon
  InputElement pokemonInput = querySelector('#pokemon-name') as InputElement;

  // Adiciona o evento de digitação no input
  pokemonInput.onInput.listen((event) {
    String nomePoke = pokemonInput.value ?? '';
      buscarTipoPokemon(nomePoke);

  });
}

Future<void> buscarTipoPokemon(String nomePoke) async {
  try {
    // Realiza a requisição HTTP para buscar os dados do Pokémon
    var response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon/$nomePoke'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // Lista para armazenar os tipos do Pokémon
      var typePokemon = <String>[];

      // Processando a lista de tipos
      for (var type in data['types']) {
        typePokemon.add(type['type']['name']);
      }
      // Exibindo as informações no HTML
      querySelector('#output')!.setInnerHtml('''
        <div class="damage-container">
          <h1>Nome: ${data['name']}</h1>
          <h2>N° na Pokédex: ${data['id']}</h2>
          <div>
            <h3>Tipos:</h3>
            <div class="damage-types">${gerarTipoDivs(typePokemon)}</div>
          </div>
        </div>
      ''', treeSanitizer: NodeTreeSanitizer.trusted);
    } else {
      // Se a resposta não for 200, exibe uma mensagem de erro
      querySelector('#output')!.setInnerHtml('''
        <div class="damage-container">
          <p>Pokémon não encontrado. Tente novamente!</p>
        </div>
      ''', treeSanitizer: NodeTreeSanitizer.trusted);
    }
  } catch (e) {
    // Se houver um erro na requisição, exibe uma mensagem de erro
    querySelector('#output')!.text = 'Campo de texto está vazio.';
  }
}

// Função para gerar as divs dos tipos dinamicamente
String gerarTipoDivs(List<String> tipos) {
  // Cria a string de divs dos tipos
  return tipos
      .map((tipo) {
        return '<div class="type-box ${tipo.toLowerCase()}">${tipo}</div>';
      })
      .join('');
}
