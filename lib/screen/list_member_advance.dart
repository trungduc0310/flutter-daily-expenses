import 'package:flutter/material.dart';

class ListMemberAdvancePage extends StatefulWidget {
  const ListMemberAdvancePage({super.key});

  @override
  State<StatefulWidget> createState() => _ListMemberAdvanceState();
}

class _ListMemberAdvanceState extends State<ListMemberAdvancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SearchViewMember(),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return const ItemMemberRemember();
              },
              itemCount: 20,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Colors.grey,
                  indent: 12,
                  endIndent: 12,
                );
              },
              shrinkWrap: true,
              physics: const ScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchViewMember extends StatelessWidget {
  const SearchViewMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
                  style: const TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(36))),
                      hintText: "Search Name"))),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_circle,
                color: Colors.green,
                size: 36,
              ))
        ],
      ),
    );
  }
}

class ItemMemberRemember extends StatelessWidget {
  const ItemMemberRemember({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                Text(
                  "Name",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Money",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
            Checkbox(value: false, onChanged: (value) {})
          ],
        ),
      ),
    );
  }
}
