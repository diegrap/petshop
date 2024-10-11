import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  final Future<String?> futureResult;

  FeedbackScreen({required this.futureResult});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, '/products', (route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Suporte'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/products', (route) => false);
            },
          ),
        ),
        body: FutureBuilder<String?>(
          future: futureResult,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data == "success") {
                return successMessage();
              } else {
                return errorMessage(snapshot);
              }
            } else {
              return unknownErrorMessage();
            }
          },
        ),
      ),
    );
  }

  Widget successMessage() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle,
              color: Color(0xFFC38D4C),
              size: 80,
            ),
            SizedBox(height: 20),
            Text(
              'Mensagem enviada com sucesso!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget errorMessage(AsyncSnapshot<String?> snapshot) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.red,
              size: 80,
            ),
            SizedBox(height: 20),
            Text(
              snapshot.data ?? 'Erro desconhecido',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget unknownErrorMessage() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.orange,
              size: 80,
            ),
            SizedBox(height: 20),
            Text(
              'Ocorreu um erro desconhecido!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
