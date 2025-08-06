import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/modules/example/data/models/example_post.dart';
import 'package:my_quran/modules/example/data/models/example_user.dart';
import 'package:my_quran/modules/example/domain/example_repository.dart';
import 'package:my_quran/modules/example/presentation/example_posts_bloc/example_posts_bloc.dart';
import 'package:my_quran/modules/example/presentation/example_users_bloc/example_users_bloc.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example View'),
      ),
      body: BlocProvider(
        create: (context) => ExampleUsersBloc(context.read<ExampleRepository>()),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: ExampleView(),
        ),
      ),
    );
  }
}

class ExampleView extends StatefulWidget {
  const ExampleView({super.key});

  @override
  State<ExampleView> createState() => _ExampleViewState();
}

class _ExampleViewState extends State<ExampleView> {
  @override
  void initState() {
    context.read<ExampleUsersBloc>().add(ExampleUsersGetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExampleUsersBloc, ExampleUsersState>(
      builder: (context, state) {
        return switch (state) {
          ExampleUsersInitial() => const Center(child: CircularProgressIndicator()),
          ExampleUsersLoading() => const Center(child: CircularProgressIndicator()),
          ExampleUsersError() => Center(child: Text(state.error.toString())),
          ExampleUsersSuccess() => ExampleSuccesWidget(state.data),
        };
      },
    );
  }
}

class ExampleSuccesWidget extends StatelessWidget {
  const ExampleSuccesWidget(this.users, {super.key});

  final List<ExampleUser> users;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: users.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              final user = users[i];
              return Card(
                child: Column(
                  children: [
                    Text(user.id.toString()),
                    Text(user.name),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        ListView.builder(
          shrinkWrap: true,
          itemCount: users.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            return UserDetailCard(users[i]);
          },
        ),
      ],
    );
  }
}

class UserDetailCard extends StatelessWidget {
  const UserDetailCard(this.user, {super.key});

  final ExampleUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(user.name),
        const SizedBox(height: 20),
        BlocProvider(
          create: (context) => ExamplePostsBloc(
            id: user.id,
            repository: context.read<ExampleRepository>(),
          )..add(ExamplePostsGetEvent()),
          child: const UserPosts(),
        ),
      ],
    );
  }
}

class UserPosts extends StatelessWidget {
  const UserPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BlocBuilder<ExamplePostsBloc, ExamplePostsState>(
        builder: (context, state) {
          return switch (state) {
            ExamplePostsInitial() => const Center(child: CircularProgressIndicator()),
            ExamplePostsLoading() => const Center(child: CircularProgressIndicator()),
            ExamplePostsError() => Center(child: Text(state.error.toString())),
            ExamplePostsSuccess() => UserPostSuccesWidget(state.data),
          };
        },
      ),
    );
  }
}

class UserPostSuccesWidget extends StatelessWidget {
  const UserPostSuccesWidget(this.data, {super.key});

  final List<ExamplePost> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) {
        final post = data[i];
        return Card(
          child: Column(
            children: [
              Text('${post.userId}'),
              Text(post.id.toString()),
              Text(post.title),
            ],
          ),
        );
      },
    );
  }
}
