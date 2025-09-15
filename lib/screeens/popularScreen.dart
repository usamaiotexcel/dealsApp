import 'package:cached_network_image/cached_network_image.dart';
import 'package:dealsapp/Bloc/dealBloc.dart';
import 'package:dealsapp/Bloc/dealEvent.dart';
import 'package:dealsapp/Bloc/dealState.dart';
import 'package:dealsapp/repository/dealRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularScreen extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DealBloc(context.read<DealRepository>())..add(LoadDeals("home/discussed")),
      child: PopularDealsView(),
    );
  }
}
class PopularDealsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<DealBloc, DealState>(
      builder: (context, state) {
        if (state is DealLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DealLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<DealBloc>().add(
                LoadDeals("home/discussed ", refresh: true),
              );
            },
            child: ListView.builder(
              itemCount: state.deals.length,
              itemBuilder: (context, index) {
                final deal = state.deals[index];

                final storeName =
                    deal.storeName.isEmpty ? "Unknown Store" : deal.storeName;

                return Card(
                  margin: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: deal.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      placeholder:
                          (context, url) => const SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      errorWidget:
                          (context, url, error) => const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ),
                    ),
                    title: 
                      Text(
                      storeName, 
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  
                      
                  ),
                );
              },
            )

          );
        } else if (state is DealError) {
          return Center(child: Text("Error: ${state.message}"));
        }
        return const Center(child: Text("No Data"));
      },
    );
  }
}
