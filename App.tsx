import React from 'react';
import {StatusBar, useColorScheme} from 'react-native';
import {TamaguiProvider} from 'tamagui';
import config from './tamagui.config';
import Navigation from './src/navigation';

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  return (
    <TamaguiProvider config={config}>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />
      <Navigation />
    </TamaguiProvider>
  );
}

export default App;
