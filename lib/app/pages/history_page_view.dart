import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String? _selectedSubject; // Estado para a matéria selecionada no filtro
  final List<String> _subjects = [
    'Português',
    'História',
    'Física',
    'Matemática',
    'Química',
    'Biologia',
  ];


  // Constrói o AppBar customizado (Seta + Título)
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 16.0, 8.0),
      child: Row(
        children: [
          // Botão de voltar
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.white, // Alterado para branco para combinar com o brilho
              size: 28,
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          const SizedBox(width: 10),
          // Título
          const Text(
            'Histórico',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Constrói o filtro de matéria (Dropdown)
  Widget _buildSubjectFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: AppColors.white, // Fundo branco
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: AppColors.gray, width: 1), // Borda cinza
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: _selectedSubject,
            hint: Text(
              'Selecione a matéria',
              style: TextStyle(color: AppColors.gray, fontSize: 16),
            ),
            icon: const Icon(Icons.arrow_drop_down, color: AppColors.gray), // Ícone de seta
            style: const TextStyle(color: AppColors.background, fontSize: 16), // Texto selecionado
            onChanged: (String? newValue) {
              setState(() {
                _selectedSubject = newValue;
                // Adicione sua lógica para filtrar a lista aqui
                print('Matéria selecionada: $_selectedSubject');
              });
            },
            items: _subjects.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // Constrói a barra de pesquisa e o botão de filtro (mantido, se for para outro filtro)
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          // Campo de Pesquisa
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.white, // Fundo branco
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                style: const TextStyle(color: AppColors.background), // Texto digitado
                decoration: InputDecoration(
                  hintText: 'Pesquisar',
                  hintStyle: TextStyle(
                    color: AppColors.gray, // Cor do "Pesquisar"
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  // Ícone de busca à direita, como na imagem
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[700], // Ícone cinza
                  ),
                  // Ajuste de padding interno
                  contentPadding: const EdgeInsets.only(
                    left: 16.0,
                    top: 14.0,
                    right: 12.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Botão de Filtro (para outros filtros, se houver)
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.white, // Fundo branco
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: IconButton(
              icon: Icon(Icons.filter_list,
                  color: AppColors.gray), // Ícone cinza
              onPressed: () {
                // Adicione sua lógica de filtro aqui
              },
            ),
          ),
        ],
      ),
    );
  }

  // Constrói a lista de cards de histórico
  Widget _buildHistoryList() {
    final int itemCount = 5;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return _buildHistoryCard(
          title: 'Física',
          description: 'imagem exemplificando os vetores...',
        );
      },
    );
  }

  // Constrói um único card de histórico (layout horizontal)
  Widget _buildHistoryCard({required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: AppColors.gray,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: AppColors.gray,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Icon(
                  Icons.insights,
                  color: AppColors.gray,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- MÉTODO BUILD ATUALIZADO ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background , // Fundo preto
      body: Stack( // Usar Stack para sobrepor o brilho
        children: [
          // 1. Efeito de brilho verde/ciano no topo
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 240, // Altura da área do brilho
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // Cor ciano com opacidade para criar o efeito de "glow"
                    const Color(0xFF21BFBF).withOpacity(1.0),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 2. Conteúdo principal da página
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                _buildSubjectFilter(), // <-- NOVO: O filtro de matéria aqui
                _buildSearchBar(),
                Expanded(
                  child: _buildHistoryList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}