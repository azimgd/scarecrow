import React, {PropsWithChildren} from 'react';
import {TouchableOpacity} from 'react-native';
import {ListItem, Separator, YStack, SizableText} from 'tamagui';
import {ArrowUp, ArrowDown} from '@tamagui/lucide-icons';
import * as ScarecrowNetwork from '../ScarecrowNetwork';

type HistoryProps = PropsWithChildren<{
  history: ScarecrowNetwork.handleDataFromFlowEventPayload[];
  handleItemSelect: (bundleIdentifier: string) => void;
}>;

function History({history, handleItemSelect}: HistoryProps): JSX.Element {
  return (
    <YStack separator={<Separator />}>
      {history.map((item, index) => (
        <TouchableOpacity
          onPress={() => handleItemSelect(item.bundleIdentifier)}
          key={index}>
          <ListItem
            backgroundColor="$borderColor"
            title={item.remoteEndpoint}
            subTitle={
              <SizableText theme="alt1" size="$3">
                {item.localizedName} {item.bundleIdentifier}
              </SizableText>
            }
            icon={
              item.direction === 'outbound' ? (
                <ArrowUp color="#0097e6" />
              ) : (
                <ArrowDown color="#44bd32" />
              )
            }>
            <SizableText theme="alt2" size="$3">
              {item.remoteUrl}
            </SizableText>
          </ListItem>
        </TouchableOpacity>
      ))}
    </YStack>
  );
}

export default History;
