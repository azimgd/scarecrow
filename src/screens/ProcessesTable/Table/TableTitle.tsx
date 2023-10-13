import React, {PropsWithChildren} from 'react';
import {SizableText, YStack} from 'tamagui';
import byteSize from 'byte-size';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import Chip from '../../../components/Chip';

type TableTitleProps = PropsWithChildren<{
  process: ScarecrowNetwork.ProcessModel;
}>;

function TableTitle({process}: TableTitleProps): JSX.Element {
  const sumFlowSize = byteSize(process.sumFlowSize);
  return (
    <YStack space="$2">
      <SizableText maxWidth="$12">{process.name}</SizableText>

      <Chip backgroundColor="$blue4">
        <SizableText theme="alt1" size="$3">
          {process.countFlows} requests
        </SizableText>
      </Chip>

      <Chip backgroundColor="$yellow4">
        <SizableText theme="alt1" size="$3">
          {sumFlowSize.value} {sumFlowSize.unit}
        </SizableText>
      </Chip>
    </YStack>
  );
}

export default TableTitle;
