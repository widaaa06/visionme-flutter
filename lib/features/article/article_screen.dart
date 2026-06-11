import 'package:flutter/material.dart';

import '../../models/article_model.dart';
import '../../services/article_service.dart';
import 'article_detail_screen.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() =>
      _ArticleScreenState();
}

class _ArticleScreenState
    extends State<ArticleScreen> {
  final TextEditingController searchController =
      TextEditingController();

  List<ArticleModel> articles = [];
  List<ArticleModel> filteredArticles = [];

  @override
  void initState() {
    super.initState();
    articles = ArticleService.getArticles();
    filteredArticles = articles;
  }

  void searchArticle(String query) {
    setState(() {
      filteredArticles = articles
          .where((article) =>
              article.title
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              article.category
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Artikel Kesehatan"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ===== BANNER =====
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF2563EB),
                  Color(0xFF60A5FA),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.health_and_safety,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Temukan tips & edukasi kesehatan mata setiap hari",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),

          // ===== SEARCH BAR =====
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: searchController,
              onChanged: searchArticle,
              decoration: InputDecoration(
                hintText: "Cari artikel kesehatan...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ===== LIST =====
          Expanded(
            child: filteredArticles.isEmpty
                ? const Center(
                    child: Text(
                      "Artikel tidak ditemukan",
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    itemCount:
                        filteredArticles.length,
                    itemBuilder: (context, index) {
                      final article =
                          filteredArticles[index];

                      return Card(
                        elevation: 4,
                        margin:
                            const EdgeInsets.only(
                          bottom: 15,
                        ),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ArticleDetailScreen(
                                  article: article,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius
                                        .vertical(
                                  top: Radius.circular(
                                    18,
                                  ),
                                ),
                                child: Image.network(
                                  article.image,
                                  height: 170,
                                  width:
                                      double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets
                                        .all(14),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    // category
                                    Container(
                                      padding:
                                          const EdgeInsets
                                              .symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration:
                                          BoxDecoration(
                                        color: Colors
                                            .blue
                                            .shade50,
                                        borderRadius:
                                            BorderRadius
                                                .circular(
                                          20,
                                        ),
                                      ),
                                      child: Text(
                                        article
                                            .category,
                                        style:
                                            const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 8,
                                    ),

                                    Text(
                                      article.title,
                                      style:
                                          const TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          article.author,
                                          style:
                                              const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),

                                        const Spacer(),

                                        const Icon(
                                          Icons.schedule,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          article.readTime,
                                          style:
                                              const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}