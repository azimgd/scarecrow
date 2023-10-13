import React, {PropsWithChildren} from 'react';
import {ListItem, YStack, SizableText} from 'tamagui';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import TableSubTitle from './Table/TableSubTitle';
import TableIconLeft from './Table/TableIconLeft';
import TableHeader from './Table/TableHeader';

type ProcessesTableProps = PropsWithChildren<{
  data: ScarecrowNetwork.ProcessModel | null;
}>;

function ProcessesTable({
  data,
}: ProcessesTableProps): JSX.Element {
  return (
    <YStack>
      <TableHeader data={data} />

      {data?.flows.map((flow, index) => (
        <ListItem
          key={index}
          title={flow.remoteEndpoint}
          subTitle={<TableSubTitle flow={flow} />}
          icon={<TableIconLeft flow={flow} />}>
          <SizableText theme="alt2" size="$3">
            {flow.remoteUrl}
          </SizableText>
        </ListItem>
      ))}
    </YStack>
  );
}

export default ProcessesTable;
