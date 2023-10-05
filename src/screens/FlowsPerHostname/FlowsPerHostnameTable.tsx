import React, {PropsWithChildren} from 'react';
import {TouchableOpacity} from 'react-native';
import {ListItem, YStack} from 'tamagui';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowsTableSubTitle from '../../components/FlowsTable/FlowsTableSubTitle';
import FlowsTableIconLeft from '../../components/FlowsTable/FlowsTableIconLeft';
import FlowsTableIconRight from '../../components/FlowsTable/FlowsTableIconRight';

type FlowsPerHostnameTableProps = PropsWithChildren<{
  data: ScarecrowNetwork.handleDataFromFlowEventPayload[];
  handleDataItemPress: (bundleIdentifier: string) => void;
  handleDataItemCheckedChange: (
    bundleIdentifier: string,
    checked: boolean,
  ) => void;
}>;

function FlowsPerHostnameTable({
  data,
  handleDataItemPress,
  handleDataItemCheckedChange,
}: FlowsPerHostnameTableProps): JSX.Element {
  return (
    <YStack>
      {data.map((flow, index) => (
        <TouchableOpacity
          onPress={() => handleDataItemPress(flow.bundleIdentifier)}
          key={index}>
          <ListItem
            title={flow.localizedName}
            subTitle={<FlowsTableSubTitle flow={flow} />}
            iconAfter={
              <FlowsTableIconRight
                flow={flow}
                handleDataItemCheckedChange={handleDataItemCheckedChange}
              />
            }
            icon={<FlowsTableIconLeft flow={flow} type="hostname" />}
          />
        </TouchableOpacity>
      ))}
    </YStack>
  );
}

export default FlowsPerHostnameTable;
