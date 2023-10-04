import React from 'react';
import {
  createStackNavigator,
  StackNavigationOptions,
} from '@react-navigation/stack';
import {NavigationContainer, DarkTheme} from '@react-navigation/native';
import Splash from '../screens/Splash';
import FlowsPerHostname from '../screens/FlowsPerHostname';
import FlowsPerHostnameExpand from '../screens/FlowsPerHostnameExpand';
import FlowsPerProcess from '../screens/FlowsPerProcess';
import FlowsPerProcessExpand from '../screens/FlowsPerProcessExpand';
import FlowRules from '../screens/FlowRules';
import {useTheme} from 'tamagui';

export type RootStackParamList = {
  FlowsPerHostname: undefined;
  FlowsPerHostnameExpand: {bundleIdentifier: string};
  FlowsPerProcess: undefined;
  FlowsPerProcessExpand: {bundleIdentifier: string};
  FlowRules: undefined;
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
        <Stack.Screen name="FlowsPerHostname" component={FlowsPerHostname} />
        <Stack.Screen name="FlowsPerProcess" component={FlowsPerProcess} />
        <Stack.Screen
          name="FlowsPerHostnameExpand"
          component={FlowsPerHostnameExpand}
        />
        <Stack.Screen
          name="FlowsPerProcessExpand"
          component={FlowsPerProcessExpand}
        />
        <Stack.Screen name="FlowRules" component={FlowRules} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

export default RootStack;
