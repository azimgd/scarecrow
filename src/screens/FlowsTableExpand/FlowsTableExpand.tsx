import React, {PropsWithChildren} from 'react';
import {ListItem, YStack, SizableText} from 'tamagui';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowsTableSubTitle from './Table/FlowsTableSubTitle';
import FlowsTableIconLeft from './Table/FlowsTableIconLeft';

type FlowsTableProps = PropsWithChildren<{
  data: ScarecrowNetwork.FlowModel[];
}>;

function FlowsTable({
  data,
}: FlowsTableProps): JSX.Element {
  return (
    <YStack>
      {data.map((flow, index) => (
        <ListItem
          key={index}
          title={flow.remoteEndpoint}
          subTitle={<FlowsTableSubTitle flow={flow} />}
          icon={<FlowsTableIconLeft flow={flow} />}>
          <SizableText theme="alt2" size="$3">
            {flow.remoteUrl}
          </SizableText>
        </ListItem>
      ))}
    </YStack>
  );
}

export default FlowsTable;
