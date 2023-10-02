import React, {PropsWithChildren} from 'react';
import {TouchableOpacity} from 'react-native';
import {ListItem, YStack, Switch} from 'tamagui';
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
            title={item.remoteEndpoint || item.bundleIdentifier}
            iconAfter={
              <Switch
                size="$2"
                defaultChecked={item.allowed}
                onCheckedChange={(checked: boolean) =>
                  handleDataItemCheckedChange(item.bundleIdentifier, checked)
                }>
                <Switch.Thumb animation="quick" />
              </Switch>
            }
            icon={<AppWindow color="#0097e6" />}
          />
        </TouchableOpacity>
      ))}
    </YStack>
  );
}

export default NetworkFlowsTable;
