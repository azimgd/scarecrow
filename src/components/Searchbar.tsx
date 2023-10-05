import React, {PropsWithChildren} from 'react';
import {StyleSheet} from 'react-native';
import {Input, YStack} from 'tamagui';

type SearchBarProps = PropsWithChildren<{}>;

function SearchBar({}: SearchBarProps): JSX.Element {
  return (
    <YStack padding="$4">
      <Input placeholder="Search by keyword" style={styles.input} />
    </YStack>
  );
}

const styles = StyleSheet.create({
  input: {
    padding: 12,
  },
});

export default SearchBar;
