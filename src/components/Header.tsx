import React from 'react';
import {NativeModules} from 'react-native';
import {Switch, XStack, H4} from 'tamagui';

const {ScarecrowNetwork} = NativeModules;

function Header(): JSX.Element {
  const handleCheckedChange = React.useCallback((value: boolean) => {
    if (value) {
      ScarecrowNetwork.enable();
    } else {
      ScarecrowNetwork.disable();
    }
  }, []);

  return (
    <XStack
      space
      padding={24}
      alignItems="center"
      justifyContent="flex-end"
      backgroundColor="#000">
      <H4 color="$white">scarecrow</H4>
      <Switch
        size="$4"
        defaultChecked={true}
        onCheckedChange={handleCheckedChange}>
        <Switch.Thumb animation="quick" />
      </Switch>
    </XStack>
  );
}

export default Header;