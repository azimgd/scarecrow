import React, {PropsWithChildren} from 'react';
import {View, XStack, ColorProp} from 'tamagui';

type ChipProps = PropsWithChildren<{
  backgroundColor: ColorProp;
}>;

function Chip({children, backgroundColor}: ChipProps): JSX.Element {
  return (
    <View
      backgroundColor={backgroundColor}
      alignSelf="flex-start"
      paddingHorizontal="$2"
      borderRadius="$2">
      <XStack space="$2" alignItems="center">
        {children}
      </XStack>
    </View>
  );
}

export default Chip;
