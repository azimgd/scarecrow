import React, {PropsWithChildren} from 'react';
import {TouchableOpacity} from 'react-native';
import {ListItem, YStack} from 'tamagui';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowsTableSubTitle from './Table/TableSubTitle';
import FlowsTableIconLeft from './Table/TableIconLeft';
import FlowsTableIconRight from './Table/TableIconRight';

type ProcessesTableProps = PropsWithChildren<{
  data: ScarecrowNetwork.ProcessModel[];
  handleDataItemPress: (bundleIdentifier: string) => void;
  handleDataItemCheckedChange: (
    bundleIdentifier: string,
    checked: boolean,
  ) => void;
}>;

function ProcessesTable({
  data,
  handleDataItemPress,
  handleDataItemCheckedChange,
}: ProcessesTableProps): JSX.Element {
  if (data.length) {
    console.log(data[0]);
  }

  return (
    <YStack>
      {data.map((process, index) => (
        <TouchableOpacity
          onPress={() => handleDataItemPress(process.bundle)}
          key={index}>
          <ListItem
            backgroundColor="$backgroundTransparent"
            title={process.name}
            subTitle={<FlowsTableSubTitle process={process} />}
            iconAfter={
              <FlowsTableIconRight
                process={process}
                handleDataItemCheckedChange={handleDataItemCheckedChange}
              />
            }
            icon={<FlowsTableIconLeft process={process} />}
          />
        </TouchableOpacity>
      ))}
    </YStack>
  );
}

export default ProcessesTable;
