import React from 'react';
import type {PropsWithChildren} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  NativeEventEmitter,
  NativeModules,
  Button,
} from 'react-native';

const {ScarecrowNetwork} = NativeModules;
const eventEmitter = new NativeEventEmitter(ScarecrowNetwork);

const logger = (event: string) => {
  console.log(event);
};

const subscription = eventEmitter.addListener('logger', logger);

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor="#333"
      />
      <ScrollView contentInsetAdjustmentBehavior="automatic">
        <Button title="enable" onPress={() => ScarecrowNetwork.enable()} />
        <Button title="disable" onPress={() => ScarecrowNetwork.disable()} />
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    margin: 10,
  },
});

export default App;
