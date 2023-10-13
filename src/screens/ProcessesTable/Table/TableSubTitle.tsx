import React, {PropsWithChildren} from 'react';
import {SizableText, XStack, YStack} from 'tamagui';
import dayjs from 'dayjs';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import FlowDirection from '../../../components/FlowDirection';

type TableSubTitleProps = PropsWithChildren<{
  process: ScarecrowNetwork.ProcessModel;
}>;

function TableSubTitle({process}: TableSubTitleProps): JSX.Element {
  return (
    <YStack>
      {process.flows.map((flow, index) => (
        <XStack space="$2" alignItems="center" key={index}>
          <FlowDirection flow={flow} width={14} />

          <SizableText theme="alt1" size="$3">
            {flow.remoteEndpoint} {dayjs.unix(flow.createdAt).fromNow()}
          </SizableText>
        </XStack>
      ))}
    </YStack>
  );
}

export default TableSubTitle;
