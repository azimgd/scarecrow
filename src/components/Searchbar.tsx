import React, {PropsWithChildren} from 'react';
import {StyleSheet} from 'react-native';
import {Input, XStack, YStack, SizableText, Separator} from 'tamagui';
import Chip from './Chip';

type SearchBarProps = PropsWithChildren<{}>;

function SearchBar({}: SearchBarProps): JSX.Element {
  return (
    <YStack paddingHorizontal="$4" space="$4">
      <Input placeholder="Search by keyword" style={styles.input} />

      <XStack justifyContent="flex-end" space="$2">
        <SizableText theme="alt1" size="$3">
          sort by:
        </SizableText>

        <Chip backgroundColor="$blue4">
          <SizableText theme="alt1" size="$3">
            frequency
          </SizableText>
        </Chip>

        <Chip backgroundColor="$yellow4">
          <SizableText theme="alt1" size="$3">
            size
          </SizableText>
        </Chip>
      </XStack>

      <Separator />
    </YStack>
  );
}

const styles = StyleSheet.create({
  input: {
    padding: 12,
  },
});

export default SearchBar;
