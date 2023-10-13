import React, {PropsWithChildren} from 'react';
import {SizableText, XStack, YStack} from 'tamagui';
import dayjs from 'dayjs';
import {ArrowUp, ArrowDown} from '@tamagui/lucide-icons';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';

type TableSubTitleProps = PropsWithChildren<{
  process: ScarecrowNetwork.ProcessModel;
}>;

function TableSubTitle({process}: TableSubTitleProps): JSX.Element {
  return (
    <YStack>
      {process.flows.map((flow, index) => (
        <XStack space="$2" alignItems="center">
          {flow.direction === 'inbound' ? (
            <ArrowDown width={14} height={14} color="$green10" />
          ) : (
            <ArrowUp width={14} height={14} color="$blue10" />
          )}

          <SizableText theme="alt1" size="$3" key={index}>
            {flow.remoteEndpoint} {dayjs.unix(flow.createdAt).fromNow()}
          </SizableText>
        </XStack>
      ))}
    </YStack>
  );
}

export default TableSubTitle;
