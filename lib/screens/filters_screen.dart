import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FilterScreen(this.currentFilters,this.saveFilters);



  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  Widget _buildSwitchTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
              final _selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegeterian': _vegetarian,
              };
              widget.saveFilters();},
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchTile(
                  'Gluten-Free',
                  'Only Includes gluten free meals',
                  _glutenFree,
                  (newValue) {
                    setState(
                      () {
                        {
                          _glutenFree = newValue;
                        }
                      },
                    );
                  },
                ),
                _buildSwitchTile(
                  'Lactose-Free',
                  'Only Includes Lactose free meals',
                  _lactoseFree,
                  (newValue) {
                    setState(
                      () {
                        {
                          _lactoseFree = newValue;
                        }
                      },
                    );
                  },
                ),
                _buildSwitchTile(
                  'Vegeterian',
                  'Only Includes Vegeterian meals',
                  _vegetarian,
                  (newValue) {
                    setState(
                      () {
                        {
                          _vegetarian = newValue;
                        }
                      },
                    );
                  },
                ),
                _buildSwitchTile(
                  'Vegan',
                  'Only Includes Vegan meals',
                  _vegan,
                  (newValue) {
                    setState(
                      () {
                        {
                          _vegan = newValue;
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
