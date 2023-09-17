import React from 'react';
import {StatusBar, useColorScheme, ScrollView} from 'react-native';
import {TamaguiProvider, XStack} from 'tamagui';
import config from './tamagui.config';
import History from './src/components/History';
import Sidebar from './src/components/Sidebar';

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  return (
    <TamaguiProvider config={config}>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />

      <XStack fullscreen backgroundColor="$background">
        <Sidebar />

        <ScrollView>
          <History />
        </ScrollView>
      </XStack>
    </TamaguiProvider>
  );
}

export default App;
