import 'package:dealsapp/Bloc/dealState.dart';
import 'package:dealsapp/repository/dealRepository.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dealsapp/Bloc/dealBloc.dart';
import 'package:dealsapp/Bloc/dealEvent.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
class FeaturedScreen extends StatelessWidget {
  const FeaturedScreen({super.key});

   @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DealBloc(context.read<DealRepository>())..add(LoadDeals("home/discussed")),
      child: FeaturedDealsView(),
    );
  }
}

class FeaturedDealsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DealBloc, DealState>(
      builder: (context, state) {
        if (state is DealLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DealLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<DealBloc>().add(
                LoadDeals("home/discussed", refresh: true),
              );
            },
            child: ListView.builder(
              itemCount: state.deals.length,
              itemBuilder: (context, index) {
                final deal = state.deals[index];
                return Card(
                  margin: EdgeInsets.all(8),
                 color: Colors.white,
                  shadowColor: Colors.black,
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: deal.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      placeholder:
                          (context, url) => Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => const Icon(
                            Icons.broken_image_outlined,
                            color: Colors.grey,
                            size: 40,
                          ),
                    ),
                    title: Text(
                      ' ${deal.storeName}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.comment),
                              label: Text(
                                (deal.commentsCount <= 0
                                        ? 0
                                        : deal.commentsCount)
                                    .toString(),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.timer),
                              label: Text(deal.createdAt),
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is DealError) {
          return Center(child: Text("Error: ${state.message}"));
        }
        return Center(child: Text("No Data"));
      },
    );
  }
}
