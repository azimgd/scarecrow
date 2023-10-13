import React, {PropsWithChildren} from 'react';
import {TouchableOpacity} from 'react-native';
import {ListItem, YStack} from 'tamagui';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import TableIconLeft from './Table/TableIconLeft';
import TableIconRight from './Table/TableIconRight';

type FlowsTableProps = PropsWithChildren<{
  data: ScarecrowNetwork.RuleModel[];
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
      {data.map((rule, index) => (
        <TouchableOpacity
          onPress={() => handleDataItemPress(rule.process.bundle)}
          key={index}>
          <ListItem
            title={rule.process.bundle}
            iconAfter={
              <TableIconRight
                rule={rule}
                handleDataItemCheckedChange={handleDataItemCheckedChange}
              />
            }
            icon={<TableIconLeft rule={rule} />}
          />
        </TouchableOpacity>
      ))}
    </YStack>
  );
}

export default FlowsTable;
