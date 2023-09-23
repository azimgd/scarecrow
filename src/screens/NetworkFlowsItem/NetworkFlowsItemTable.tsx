import React, {PropsWithChildren} from 'react';
import {ListItem, YStack, SizableText} from 'tamagui';
import {ArrowUp, ArrowDown} from '@tamagui/lucide-icons';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';

type NetworkFlowsItemTableProps = PropsWithChildren<{
  data: ScarecrowNetwork.handleDataFromFlowEventPayload[];
}>;

function NetworkFlowsItemTable({
  data,
}: NetworkFlowsItemTableProps): JSX.Element {
  return (
    <YStack>
      {data.map((item, index) => (
        <ListItem
          key={index}
          backgroundColor="$borderColor"
          title={item.remoteEndpoint}
          subTitle={
            <SizableText theme="alt1" size="$3">
              {item.localizedName} {item.bundleIdentifier}
            </SizableText>
          }
          icon={
            item.direction === 'outbound' ? (
              <ArrowUp color="#0097e6" />
            ) : (
              <ArrowDown color="#44bd32" />
            )
          }>
          <SizableText theme="alt2" size="$3">
            {item.remoteUrl}
          </SizableText>
        </ListItem>
      ))}
    </YStack>
  );
}

export default NetworkFlowsItemTable;
