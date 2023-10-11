import React, {PropsWithChildren} from 'react';
import {ListItem, YStack, SizableText} from 'tamagui';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowsTableSubTitle from './Table/FlowsTableSubTitle';
import FlowsTableIconLeft from './Table/FlowsTableIconLeft';

type ProcessesTableProps = PropsWithChildren<{
  data: ScarecrowNetwork.ProcessModel[];
}>;

function ProcessesTable({
  data,
}: ProcessesTableProps): JSX.Element {
  return (
    <YStack>
      {data.map((process, index) => (
        <ListItem
          key={index}
          title={process.name}
          subTitle={<FlowsTableSubTitle process={process} />}
          icon={<FlowsTableIconLeft process={process} />}>
          <SizableText theme="alt2" size="$3">
            {process.path}
          </SizableText>
        </ListItem>
      ))}
    </YStack>
  );
}

export default ProcessesTable;
