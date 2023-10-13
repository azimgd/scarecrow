import React, {PropsWithChildren} from 'react';
import {TouchableOpacity} from 'react-native';
import {XStack, YStack, Separator} from 'tamagui';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import TableSubTitle from './Table/TableSubTitle';
import TableIconLeft from './Table/TableIconLeft';
import TableIconRight from './Table/TableIconRight';
import TableTitle from './Table/TableTitle';

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
  return (
    <YStack>
      {data.map((process, index) => (
        <TouchableOpacity
          onPress={() => handleDataItemPress(process.bundle)}
          key={index}>
          <XStack padding="$4">
            <XStack width="$18" space="$4">
              <TableIconLeft process={process} />
              <TableTitle process={process} />
            </XStack>

            <XStack flex={1}>
              <TableSubTitle process={process} />
            </XStack>

            <TableIconRight
              process={process}
              handleDataItemCheckedChange={handleDataItemCheckedChange}
            />
          </XStack>

          <Separator />
        </TouchableOpacity>
      ))}
    </YStack>
  );
}

export default ProcessesTable;
