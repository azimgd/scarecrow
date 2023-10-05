import React, {PropsWithChildren} from 'react';
import {PressableProps} from 'react-native';
import {ListItem, Text} from 'tamagui';

type SidebarItemProps = PropsWithChildren<{
  onPress: PressableProps['onPress'];
  active: boolean;
  title: string;
  icon: JSX.Element;
  iconRightText: string | number;
}>;

function SidebarItem({
  onPress,
  active,
  title,
  icon,
  iconRightText,
}: SidebarItemProps): JSX.Element {
  return (
    <ListItem
      onPress={onPress}
      borderRadius="$4"
      backgroundColor={active ? '$backgroundFocus' : '$colorTransparent'}
      title={title}
      icon={icon}
      iconAfter={
        <Text color="#cccccc" fontSize="$2">
          {iconRightText}
        </Text>
      }
    />
  );
}

export default SidebarItem;
