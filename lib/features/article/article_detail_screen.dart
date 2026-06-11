import 'package:flutter/material.dart';

import '../../models/article_model.dart';

class ArticleDetailScreen extends StatelessWidget {
  final ArticleModel article;

  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                article.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              background: Image.network(
                article.image,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Text(
                      article.category,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(article.author),

                      const Spacer(),

                      const Icon(
                        Icons.schedule,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(article.readTime),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Text(
                    article.content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}