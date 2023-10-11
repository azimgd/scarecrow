import React, {PropsWithChildren} from 'react';
import {ListItem, YStack, SizableText} from 'tamagui';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowsTableSubTitle from '../../components/FlowsTable/FlowsTableSubTitle';
import FlowsTableIconLeft from '../../components/FlowsTable/FlowsTableIconLeft';

type FlowsPerHostnameExpandTableProps = PropsWithChildren<{
  data: ScarecrowNetwork.FlowModel[];
}>;

function FlowsPerHostnameExpandTable({
  data,
}: FlowsPerHostnameExpandTableProps): JSX.Element {
  return (
    <YStack>
      {data.map((flow, index) => (
        <ListItem
          key={index}
          title={flow.remoteEndpoint}
          subTitle={<FlowsTableSubTitle flow={flow} />}
          icon={<FlowsTableIconLeft flow={flow} type="default" />}>
          <SizableText theme="alt2" size="$3">
            {flow.remoteUrl}
          </SizableText>
        </ListItem>
      ))}
    </YStack>
  );
}

export default FlowsPerHostnameExpandTable;
