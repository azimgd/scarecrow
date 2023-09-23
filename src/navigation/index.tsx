import React from 'react';
import {createStackNavigator} from '@react-navigation/stack';
import {NavigationContainer} from '@react-navigation/native';
import NetworkFlows from '../screens/NetworkFlows';
import NetworkFlowsItem from '../screens/NetworkFlowsItem';

export type RootStackParamList = {
  NetworkFlows: undefined;
  NetworkFlowsItem: {bundleIdentifier: string};
};

const Stack = createStackNavigator<RootStackParamList>();

function RootStack() {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="NetworkFlows" component={NetworkFlows} />
        <Stack.Screen name="NetworkFlowsItem" component={NetworkFlowsItem} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

export default RootStack;
