import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  // Faz a requisição para a API
  var response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/ditto'));

  if (response.statusCode == 200) {
    // Converte a resposta em um Map
    var data = jsonDecode(response.body);
    //printa no h1 que o id é output
    querySelector('#output')!.text = 'Pegando valor do json da api: ${data['name']}'; // o name é como ta no json
  } else {
    querySelector('#output')!.text = 'Erro ao carregar dados';
  }
}
