import React, {PropsWithChildren} from 'react';
import {ListItem, Text, View, XStack, YStack} from 'tamagui';
import Sidebar from '../components/Sidebar';

type WindowProps = PropsWithChildren<{
  title: string;
}>;

function Window({children, title}: WindowProps): JSX.Element {
  return (
    <XStack flex={1}>
      <Sidebar />

      <YStack flex={1}>
        <ListItem
          backgroundColor="$colorTransparent"
          borderBottomColor="$borderColor"
          borderBottomWidth="$0.25">
          <Text color="#cccccc">{title}</Text>
        </ListItem>

        <View borderLeftColor="$borderColor" borderLeftWidth="$0.5" flex={1}>
          {children}
        </View>
      </YStack>
    </XStack>
  );
}

export default Window;
