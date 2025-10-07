import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<String> _subjects = [
    'Química', 'Física', 'Matemática',
  ];
  // modal de filtro
  String? _selectedSubject = 'Química';
  String? _selectedType = 'Realismo';

  // Cores 
  static const Color _cardBackgroundColor = Color(0xFFF0A500); 
  static const Color _headerColor = Color(0xFF4DB6AC); 

  //widgte card
  Widget _buildContentCard({
    required String subject,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.all(4.0), 
      decoration: BoxDecoration(
        color: _cardBackgroundColor, 
        borderRadius: BorderRadius.circular(15.0), 

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Área da Imagem Branca
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0), 
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, // Fundo branco
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  // Placeholder para a imagem/diagrama de vetores
                  child: Icon(
                    Icons.speed, 
                    color: Colors.grey[700],
                    size: 35, // Tamanho menor para caber no grid
                  ),
                ),
              ),
            ),
          ),
          
          // Texto card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              subject,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 2),


          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 8.0), 
            child: Text(
              description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // WIDGETS 
  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return _buildFilterContent(context, setModalState); 
          },
        );
      },
      isScrollControlled: true, 
      backgroundColor: Colors.transparent, 
    );
  }

  Widget _buildFilterContent(BuildContext context, StateSetter setModalState) {
    final List<String> subjects = [ 'Física', 'Química', 'Matemática'];
    final List<String> imageTypes = ['Realismo', 'Arte de rua', 'Psicodélico', 'Desenho animado'];

    return Container(
      height: MediaQuery.of(context).size.height * 0.7, 
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          // Cabeçalho
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
            decoration: const BoxDecoration(
              color: _headerColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context), 
                ),
                const Spacer(),
              ],
            ),
          ),
          // Conteúdo do Filtro
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[300], 
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedSubject, 
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        hint: const Text('Selecione a matéria'),
                        onChanged: (String? newValue) {
                          setModalState(() { _selectedSubject = newValue; });
                        },
                        items: subjects.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(value: value, child: Text(value));
                        }).toList(),
                      ),
                    ),
                  ),
                  if (_selectedSubject != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[600], 
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(_selectedSubject!, style: const TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Tipo de imagem', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 10),
                  ...imageTypes.map((type) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: _buildFilterButton(
                          text: type,
                          isSelected: type == _selectedType, 
                          onPressed: () { setModalState(() { _selectedType = type; }); },
                        ),
                      )).toList(),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildActionButton(
                        text: 'Cancelar', color: Colors.pink[400]!, textColor: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 10),
                      _buildActionButton(
                        text: 'Aplicar', color: Colors.grey[300]!, textColor: Colors.black,
                        onPressed: () { Navigator.pop(context); },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton({required String text, required bool isSelected, required VoidCallback onPressed,}) {
    return SizedBox(width: double.infinity, child: TextButton(onPressed: onPressed, style: TextButton.styleFrom(backgroundColor: isSelected ? Colors.grey[600] : Colors.grey[300], padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text(text, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontSize: 16))));
  }

  Widget _buildActionButton({required String text, required Color color, required Color textColor, required VoidCallback onPressed,}) {
    return Expanded(child: TextButton(onPressed: onPressed, style: TextButton.styleFrom(backgroundColor: color, padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text(text, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold))));
  }

  // barra de pesquisa
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10.0)),
              child: const TextField(decoration: InputDecoration(hintText: 'Pesquisar', border: InputBorder.none, prefixIcon: Icon(Icons.search, color: Colors.grey), prefixIconConstraints: BoxConstraints(minWidth: 40))),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 48, width: 48,
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10.0)),
            child: IconButton(icon: const Icon(Icons.filter_list, color: Colors.grey), onPressed: () { _showFilterModal(context); }),
          ),
        ],
      ),
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Column(
        children: [
          // Seta de voltar
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10),
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () { if (Navigator.canPop(context)) { Navigator.pop(context); } }),
              ],
            ),
          ),
          
          _buildSearchBar(),
          
          //container em colunas
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                itemCount: _subjects.length, // Não incluímos o "Mais" no GridView
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 colunas
                  crossAxisSpacing: 8.0, // Espaçamento horizontal
                  mainAxisSpacing: 8.0, // Espaçamento vertical
                  childAspectRatio: 0.75, // Proporção Altura/Largura (ajuste para o visual do seu card)
                ),
                itemBuilder: (context, index) {
                  return _buildContentCard(
                    subject: _subjects[index],
                    description: 'imagem exemplificando os vetores...',
                  );
                },
              ),
            ),
          ),
          
          // botão "Mais"
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Mais',
                  style: TextStyle(
                    color: Color(0xFF1E88E5),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}