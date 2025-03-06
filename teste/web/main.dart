import 'dart:html';

void main() {
  // Selecionar o botão de envio
  ButtonElement submitButton = querySelector('#submitBtn') as ButtonElement;
  
  // Adicionar evento de clique ao botão
  submitButton.onClick.listen((event) {
    // Obter os valores dos campos de input
    String name = (querySelector('#name') as InputElement).value ?? '';
    String age = (querySelector('#age') as InputElement).value ?? '';

    // Exibir a saudação personalizada
    if (name.isNotEmpty && age.isNotEmpty) {
      querySelector('#greeting')?.text = 'Olá, $name! Você tem $age anos.';
    } else {
      querySelector('#greeting')?.text = 'Por favor, preencha todos os campos.';
    }
  });
}
