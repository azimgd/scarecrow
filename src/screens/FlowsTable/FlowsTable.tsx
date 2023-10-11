import React, {PropsWithChildren} from 'react';
import {TouchableOpacity} from 'react-native';
import {ListItem, YStack} from 'tamagui';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowsTableSubTitle from './Table/FlowsTableSubTitle';
import FlowsTableIconLeft from './Table/FlowsTableIconLeft';
import FlowsTableIconRight from './Table/FlowsTableIconRight';

type FlowsTableProps = PropsWithChildren<{
  data: ScarecrowNetwork.FlowModel[];
  handleDataItemPress: (bundleIdentifier: string) => void;
  handleDataItemCheckedChange: (
    bundleIdentifier: string,
    checked: boolean,
  ) => void;
}>;

function FlowsTable({
  data,
  handleDataItemPress,
  handleDataItemCheckedChange,
}: FlowsTableProps): JSX.Element {
  return (
    <YStack>
      {data.map((flow, index) => (
        <TouchableOpacity
          onPress={() => handleDataItemPress(flow.bundle)}
          key={index}>
          <ListItem
            title={flow.remoteEndpoint}
            subTitle={<FlowsTableSubTitle flow={flow} />}
            iconAfter={<FlowsTableIconRight flow={flow} />}
            icon={<FlowsTableIconLeft flow={flow} />}
          />
        </TouchableOpacity>
      ))}
    </YStack>
  );
}

export default FlowsTable;
