import React, {PropsWithChildren} from 'react';
import {TouchableOpacity} from 'react-native';
import {ListItem, YStack} from 'tamagui';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import TableSubTitle from './Table/TableSubTitle';
import TableIconLeft from './Table/TableIconLeft';
import TableIconRight from './Table/TableIconRight';

type FlowsTableProps = PropsWithChildren<{
  data: ScarecrowNetwork.FlowModel[];
  handleDataItemPress: (id: number) => void;
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
          onPress={() => handleDataItemPress(flow.id)}
          key={index}>
          <ListItem
            title={flow.remoteEndpoint}
            subTitle={<TableSubTitle flow={flow} />}
            iconAfter={<TableIconRight flow={flow} />}
            icon={<TableIconLeft flow={flow} />}
          />
        </TouchableOpacity>
      ))}
    </YStack>
  );
}

export default FlowsTable;
