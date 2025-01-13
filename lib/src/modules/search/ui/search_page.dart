import 'package:dev_search/src/modules/user/controller/user_controller.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final UserController userController;

  const SearchPage({super.key, required this.userController});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 255, bottom: 32),
              child: SizedBox(
                child: Image.asset(
                  'asset/images/logo.png',
                  width: 305,
                  height: 68,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Pesquisar...',
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(color: Colors.purple, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  prefixIcon: Icon(Icons.search, color: Colors.purple),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                String query = _textController.text.trim();
                if (query.isNotEmpty) {
                  await widget.userController.fetchUsers(query);
                  if (widget.userController.error.isEmpty && widget.userController.user.userId != null) {
                    Navigator.of(context).pushNamed('/user');
                  } else {
                    _showErrorSnackbar(widget.userController.error.isEmpty ? 'Usuário não encontrado' : 'Erro: ${widget.userController.error}');
                  }
                } else {
                  _showErrorSnackbar('Digite o nome do usuário');
                }
              },
              child: Container(
                width: 180,
                height: 50,
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 170, 118, 255),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Text(
                    'Buscar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
