import React, {PropsWithChildren} from 'react';
import {XStack, YStack} from 'tamagui';
import Sidebar from '../components/Sidebar';
import Header from '../components/Header';

type WindowProps = PropsWithChildren<{
  title: string;
}>;

function Window({children, title}: WindowProps): JSX.Element {
  return (
    <XStack flex={1}>
      <Sidebar />

      <YStack flex={1} borderLeftColor="$borderColor" borderLeftWidth="$0.5">
        <Header title={title} />

        {children}
      </YStack>
    </XStack>
  );
}

export default Window;
