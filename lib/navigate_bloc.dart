import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'app_conifg.dart';

/**
 * Navigation Bloc : State definition.
 */

class NavState extends Equatable {
  final RouteName previousPageName;
  final RouteName pageName;

  NavState({@required this.pageName, @required this.previousPageName}) : super([pageName, previousPageName]);

  List<BottomNavigationBarItem> get pageNavBarItem {
    List<IconData> _icons = <IconData>[
      Icons.group,
      Icons.notifications,
    ];
    Color iconColor;
    List<BottomNavigationBarItem> barItems = <BottomNavigationBarItem>[];
    Widget barIcon;
    for (int i = 0; i < _icons.length; i++) {
      if (pageName.index == i) {
        iconColor = Colors.green;
      } else {
        iconColor = Colors.black;
      }

      barIcon = SizedBox(
        // child: Image.asset(iconsNames[i], color: iconColor, ),
        child: Icon(_icons[i], color: iconColor,),
        width: AppConfig.instance.blockWidth * 4.5,
        height: AppConfig.instance.blockHeight * 4.5,
      );

      barItems.add(BottomNavigationBarItem(
        icon: barIcon,
        title: Text(RouteName.values[i].toString()),
      ));
      // icons.add(Image.asset(iconsPath[i], color: iconColor,));
    }
    return barItems;
  }
}

/**
 * Navigation Bloc : Event definition.
 */
@immutable
abstract class NavEvent extends Equatable {
  NavEvent([List props = const []]) : super(props);
}

class NavTo extends NavEvent {
  final RouteName previousPageName;
  final RouteName pageName;

  NavTo({@required this.pageName, @required this.previousPageName});
}

/**
 * Navigation Bloc : mapEventToState
 */
class NavBloc extends Bloc<NavEvent, NavState> {
  @override
  NavState get initialState => NavState(pageName: RouteName.Meeting, previousPageName: RouteName.Meeting);

  @override
  Stream<NavState> mapEventToState(
    NavEvent event,
  ) async* {
    if(event is NavTo){
      yield NavState(pageName: event.pageName, previousPageName: event.previousPageName);
    }
  }
}
