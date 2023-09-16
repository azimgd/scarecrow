import React from 'react';
import {StatusBar, useColorScheme, ScrollView} from 'react-native';
import {TamaguiProvider, YStack} from 'tamagui';
import config from './tamagui.config';
import History from './src/components/History';
import Header from './src/components/Header';

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  return (
    <TamaguiProvider config={config}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor="#333"
      />

      <YStack fullscreen>
        <Header />

        <ScrollView>
          <History />
        </ScrollView>
      </YStack>
    </TamaguiProvider>
  );
}

export default App;
