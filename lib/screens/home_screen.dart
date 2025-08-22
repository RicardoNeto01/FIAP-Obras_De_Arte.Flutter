import 'package:flutter/material.dart';
import 'package:obras_de_arte/data/artwork_repository.dart';
import 'package:obras_de_arte/data/models/artwork.dart';
import 'package:obras_de_arte/widget/artwork_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final repository = ArtworkRepository();
    return Scaffold(
      appBar: AppBar(title: const Text("Obras de Arte")),
      body: FutureBuilder<List<Artwork>>(
        future: repository.fetchArtworks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar obras'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma obra encontrada'));
          } else {
            final artworks = snapshot.data!;
            return ListView.builder(
              itemCount: artworks.length,
              itemBuilder: (context, index) {
                final art = artworks[index];
                return ArtworkListItem(artwork: art);
              },
            );

            // Código da construção da lista no próximo slide
          }
        },
      ),
    );
  }
}
