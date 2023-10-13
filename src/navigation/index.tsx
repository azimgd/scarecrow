import React from 'react';
import {
  createStackNavigator,
  StackNavigationOptions,
} from '@react-navigation/stack';
import {NavigationContainer, DarkTheme} from '@react-navigation/native';
import Splash from '../screens/Splash';
import FlowsTable from '../screens/FlowsTable';
import FlowsTableExpand from '../screens/FlowsTableExpand';
import ProcessesTable from '../screens/ProcessesTable';
import ProcessesTableExpand from '../screens/ProcessesTableExpand';
import RulesTable from '../screens/RulesTable';
import {useTheme} from 'tamagui';

export type RootStackParamList = {
  FlowsTable: undefined;
  FlowsTableExpand: {flowId: number};
  ProcessesTable: undefined;
  ProcessesTableExpand: {processId: number};
  RulesTable: undefined;
  Splash: undefined;
};

const Stack = createStackNavigator<RootStackParamList>();

function RootStack() {
  const theme = useTheme();

  const navigationTheme = React.useMemo(
    () => ({
      ...DarkTheme,
      colors: {
        ...DarkTheme.colors,
        background: theme.background.val,
        card: theme.borderColor.val,
      },
    }),
    [theme],
  );

  const screenOptions = React.useMemo<StackNavigationOptions>(
    () => ({
      headerShown: false,
    }),
    [],
  );

  return (
    <NavigationContainer theme={navigationTheme}>
      <Stack.Navigator screenOptions={screenOptions}>
        <Stack.Screen name="Splash" component={Splash} />
        <Stack.Screen name="FlowsTable" component={FlowsTable} />
        <Stack.Screen name="ProcessesTable" component={ProcessesTable} />
        <Stack.Screen name="FlowsTableExpand" component={FlowsTableExpand} />
        <Stack.Screen
          name="ProcessesTableExpand"
          component={ProcessesTableExpand}
        />
        <Stack.Screen name="RulesTable" component={RulesTable} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

export default RootStack;
