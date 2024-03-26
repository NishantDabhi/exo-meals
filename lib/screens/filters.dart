import 'package:flutter/material.dart';
import 'package:meals/main.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vagetarian,
  vegen
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;
  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _vegenFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vagetarian]!;
    _vegenFilterSet = widget.currentFilters[Filter.vegen]!;

  }


  @override
  Widget build(context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didpop) {
        if(didpop) return;
        Navigator.of(context).pop({
          Filter.glutenFree : _glutenFreeFilterSet,
          Filter.lactoseFree : _lactoseFreeFilterSet,
          Filter.vagetarian : _vegetarianFilterSet,
          Filter.vegen : _vegenFilterSet,
        }
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
        ),
        body: Column(
          children: [
            SwitchListTile(
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
      },
              value: _glutenFreeFilterSet,
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              subtitle: Text(
                'Only Include Gluten-free meals',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
              ),
            ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              value: _lactoseFreeFilterSet,
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              subtitle: Text(
                'Only Include Lactose-free meals',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
              value: _vegetarianFilterSet,
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              subtitle: Text(
                'Only Include Vegetarian meals',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              onChanged: (isChecked) {
                setState(() {
                  _vegenFilterSet = isChecked;
                });
              },
              value: _vegenFilterSet,
              title: Text(
                'Vegen',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              subtitle: Text(
                'Only Include Vegen meals',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}