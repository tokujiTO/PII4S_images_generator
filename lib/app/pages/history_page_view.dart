// import 'package:flutter/material.dart';

// class HistoryPage extends StatefulWidget {
//   const HistoryPage({super.key});

//   @override
//   State<HistoryPage> createState() => _HistoryPageState();
// }

// class _HistoryPageState extends State<HistoryPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('History Page')),
//       body: const Center(child: Text('Welcome to the History Page!')),
//     );
//   }
// }

import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Dados de exemplo para popular a lista
  final List<String> _subjects = List.generate(
      6, (index) => 'Física'); // 6 itens para replicar a primeira imagem

  // Cor personalizada para o fundo laranja/âmbar (baseado na imagem)
  static const Color _cardBackgroundColor = Color(0xFFF0A500);

  // Widget reutilizável para o item de conteúdo (o card laranja)
  Widget _buildContentCard({
    required String subject,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        // O Container principal é o card laranja/âmbar
        decoration: BoxDecoration(
          color: _cardBackgroundColor,
          borderRadius: BorderRadius.circular(15.0), // Cantos arredondados
          boxShadow: [
            // Sombra sutil para dar profundidade, opcional
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Espaçamento interno do card
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coluna para o texto (Física + descrição)
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // O Container branco com a 'imagem' do vetor
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // Fundo branco
                    borderRadius: BorderRadius.circular(10.0), // Cantos arredondados
                  ),
                  // Placeholder para a imagem, usando um ícone simples para simular o desenho
                  child: AspectRatio(
                    aspectRatio: 1.0, // Para manter o card da imagem quadrado
                    child: Center(
                      // Este é um placeholder do diagrama vetorial
                      // Na aplicação real, você usaria um Image.asset ou outro widget de imagem aqui
                      child: Icon(
                        Icons.construction, // Exemplo de Ícone que remete a um diagrama
                        color: Colors.grey[700],
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Função para o Topo (Busca e Filtro) ---
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Pesquisar',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  prefixIconConstraints: BoxConstraints(minWidth: 40),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 48, // Ajuste a altura para corresponder ao TextField
            width: 48,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Icon(Icons.filter_list, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Removendo o AppBar padrão e usando um Column com o topo personalizado
      body: Column(
        children: [
          // Área superior (Seta de voltar, Busca e Filtro)
          // Adicionar o espaço da barra de status
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    // Implementar a navegação de volta
                    Navigator.pop(context);
                  },
                ),
                // O resto da área de busca será construído separadamente
              ],
            ),
          ),
          
          _buildSearchBar(),
          
          // --- Lista de Conteúdo ---
          Expanded(
            child: ListView.builder(
              itemCount: _subjects.length + 1, // +1 para o botão "Mais"
              itemBuilder: (context, index) {
                if (index == _subjects.length) {
                  // Último item: O botão "Mais"
                  return Center(
                    child: TextButton(
                      onPressed: () {
                        // Ação para carregar mais itens
                      },
                      child: const Text(
                        'Mais',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }
                
                // Item da lista (Card Laranja)
                return _buildContentCard(
                  subject: _subjects[index],
                  description: 'imagem exemplificando os vetores...',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}