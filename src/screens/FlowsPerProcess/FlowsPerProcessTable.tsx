import React, {PropsWithChildren} from 'react';
import {TouchableOpacity} from 'react-native';
import {ListItem, YStack} from 'tamagui';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowsTableSubTitle from '../../components/FlowsTable/FlowsTableSubTitle';
import FlowsTableIconLeft from '../../components/FlowsTable/FlowsTableIconLeft';
import FlowsTableIconRight from '../../components/FlowsTable/FlowsTableIconRight';

type FlowsPerProcessTableProps = PropsWithChildren<{
  data: ScarecrowNetwork.ProcessModel[];
  handleDataItemPress: (bundleIdentifier: string) => void;
  handleDataItemCheckedChange: (
    bundleIdentifier: string,
    checked: boolean,
  ) => void;
}>;

function FlowsPerProcessTable({
  data,
  handleDataItemPress,
  handleDataItemCheckedChange,
}: FlowsPerProcessTableProps): JSX.Element {
  return (
    <YStack>
      {data.map((flow, index) => (
        <TouchableOpacity
          onPress={() => handleDataItemPress(flow.bundleIdentifier)}
          key={index}>
          <ListItem
            backgroundColor="$backgroundTransparent"
            title={flow.name}
            subTitle={<FlowsTableSubTitle flow={flow} />}
            iconAfter={
              <FlowsTableIconRight
                flow={flow}
                handleDataItemCheckedChange={handleDataItemCheckedChange}
              />
            }
            icon={<FlowsTableIconLeft flow={flow} type="process" />}
          />
        </TouchableOpacity>
      ))}
    </YStack>
  );
}

export default FlowsPerProcessTable;
