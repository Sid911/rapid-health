import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/global/author_card.dart';
import 'package:rapid_health/global/loading_wrapper.dart';
import 'package:rapid_health/global/not_found_wrapper.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/interfaces/search_service_interface.dart';
import 'package:rapid_health/pages/search/search_widget.dart';
import 'package:rapid_health/utility/user.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({Key? key}) : super(key: key);

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  final _searchController = TextEditingController();
  late AuthServiceInterface authService;
  late SearchServiceInterface searchService;
  String searchTerm = "";

  @override
  void initState() {
    super.initState();
    searchService = context.read<SearchServiceInterface>();
    _searchController.addListener(() {
      setState(() {
        searchTerm = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchWidget(controller: _searchController),
              FutureBuilder<List<User>>(
                future: searchService.searchPeople(searchTerm),
                builder: (context, snap) {
                  if (snap.hasData) {
                    final data = snap.data!;
                    if (data.isEmpty) {
                      return const NotFoundWrapper(
                        text: 'No Similar People Found',
                        height: 200,
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shrinkWrap: true,
                      physics: const PageScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return _buildPeople(context, data[index], theme);
                      },
                    );
                  }
                  return const LoadingWrapper();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPeople(BuildContext context, User data, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: AuthorCard(user: data),
    );
  }
}
