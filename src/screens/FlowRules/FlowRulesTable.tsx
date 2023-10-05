import React, {PropsWithChildren} from 'react';
import {TouchableOpacity} from 'react-native';
import {ListItem, YStack} from 'tamagui';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import RulesTableIconLeft from '../../components/RulesTable/RulesTableIconLeft';
import RulesTableIconRight from '../../components/RulesTable/RulesTableIconRight';

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
      {data.map((rule, index) => (
        <TouchableOpacity
          onPress={() => handleDataItemPress(rule.bundleIdentifier)}
          key={index}>
          <ListItem
            title={rule.remoteEndpoint || rule.bundleIdentifier}
            iconAfter={
              <RulesTableIconRight
                rule={rule}
                handleDataItemCheckedChange={handleDataItemCheckedChange}
              />
            }
            icon={<RulesTableIconLeft rule={rule} />}
          />
        </TouchableOpacity>
      ))}
    </YStack>
  );
}

export default FlowsPerHostnameTable;
