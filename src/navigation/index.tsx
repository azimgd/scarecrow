import React from 'react';
import {
  createStackNavigator,
  StackNavigationOptions,
} from '@react-navigation/stack';
import {NavigationContainer, DarkTheme} from '@react-navigation/native';
import NetworkFlows from '../screens/NetworkFlows';
import NetworkFlowsItem from '../screens/NetworkFlowsItem';
import FlowRules from '../screens/FlowRules';
import {useTheme} from 'tamagui';

export type RootStackParamList = {
  NetworkFlows: {viewBy: 'bundleIdentifier' | 'remoteEndpoint'};
  NetworkFlowsItem: {bundleIdentifier: string};
  FlowRules: undefined;
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
        <Stack.Screen
          name="NetworkFlows"
          component={NetworkFlows}
          initialParams={{viewBy: 'bundleIdentifier'}}
        />
        <Stack.Screen name="NetworkFlowsItem" component={NetworkFlowsItem} />
        <Stack.Screen name="FlowRules" component={FlowRules} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

export default RootStack;
