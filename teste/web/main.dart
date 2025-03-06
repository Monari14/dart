import 'dart:html';

void main() {
  // Criando uma barra de navegação simples
  var nav = DivElement();
  var homeLink = AnchorElement(href: '#home')..text = 'Página Inicial';
  var aboutLink = AnchorElement(href: '#about')..text = 'Sobre';

  nav..append(homeLink)..append(aboutLink);
  document.body?.append(nav);

  // Exibir conteúdo dependendo do link clicado
  homeLink.onClick.listen((event) {
    event.preventDefault();
    querySelector('#content')!.text = 'Bem-vindo à Página Inicial!';
  });

  aboutLink.onClick.listen((event) {
    event.preventDefault();
    querySelector('#content')!.text = 'Esta é a página sobre nós!';
  });

  // Div para exibir o conteúdo
  document.body?.append(DivElement()..id = 'content');
}
