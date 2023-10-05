import React, {PropsWithChildren} from 'react';
import {ListItem, Separator, Text, YStack} from 'tamagui';

type HeaderProps = PropsWithChildren<{
  title: string;
  color?: string;
}>;

function Header({title, color}: HeaderProps): JSX.Element {
  return (
    <YStack marginBottom="$2">
      <ListItem backgroundColor="$colorTransparent">
        <Text fontWeight="600" color={color}>
          {title}
        </Text>
      </ListItem>

      <Separator marginBottom="$2" />
    </YStack>
  );
}

export default Header;
