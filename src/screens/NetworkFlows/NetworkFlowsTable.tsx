import React, {PropsWithChildren} from 'react';
import {TouchableOpacity} from 'react-native';
import {ListItem, YStack, SizableText, Switch, Image} from 'tamagui';
import {AppWindow} from '@tamagui/lucide-icons';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';

type NetworkFlowsTableProps = PropsWithChildren<{
  data: ScarecrowNetwork.handleDataFromFlowEventPayload[];
  handleDataItemPress: (bundleIdentifier: string) => void;
  handleDataItemCheckedChange: (
    bundleIdentifier: string,
    checked: boolean,
  ) => void;
}>;

function NetworkFlowsTable({
  data,
  handleDataItemPress,
  handleDataItemCheckedChange,
}: NetworkFlowsTableProps): JSX.Element {
  return (
    <YStack>
      {data.map((item, index) => (
        <TouchableOpacity
          onPress={() => handleDataItemPress(item.bundleIdentifier)}
          key={index}>
          <ListItem
            title={item.remoteEndpoint}
            subTitle={
              <SizableText theme="alt1" size="$3">
                {item.localizedName || item.bundleIdentifier || 'System'}{' '}
                {item.totalSize.toFixed(2)} kb {item.totalCount} items
              </SizableText>
            }
            iconAfter={
              <Switch
                size="$2"
                defaultChecked={true}
                onCheckedChange={(checked: boolean) =>
                  handleDataItemCheckedChange(item.bundleIdentifier, checked)
                }>
                <Switch.Thumb animation="quick" />
              </Switch>
            }
            icon={
              item.image ? (
                <Image
                  source={{uri: `data:image/png;base64,${item.image}`}}
                  width={20}
                  height={20}
                />
              ) : (
                <AppWindow width={20} height={20} strokeWidth={1.5} />
              )
            }
          />
        </TouchableOpacity>
      ))}
    </YStack>
  );
}

export default NetworkFlowsTable;
