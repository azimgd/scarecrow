import React, {PropsWithChildren} from 'react';
import {H4, SizableText, YStack, XStack} from 'tamagui';
import byteSize from 'byte-size';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';

type TableHeaderProps = PropsWithChildren<{
  data: ScarecrowNetwork.ProcessModel | null;
}>;

function TableHeader({
  data,
}: TableHeaderProps): JSX.Element {
  const sumFlowSize = byteSize(data?.sumFlowSize || 0);

  return (
    <XStack flex={1} paddingHorizontal="$4" marginBottom="$2">
      <YStack
        flex={1}
        padding="$4"
        space="$4"
        backgroundColor="$blue4"
        borderRadius="$4">
        <YStack>
          <H4>{data?.name}</H4>
          <SizableText>{data?.path}</SizableText>
        </YStack>

        <XStack>
          <YStack flex={1}>
            <H4>Requests</H4>
            <SizableText>{data?.countFlows}</SizableText>
          </YStack>

          <YStack flex={1}>
            <H4>Size</H4>
            <SizableText>
              {sumFlowSize.value} {sumFlowSize.unit}
            </SizableText>
          </YStack>
        </XStack>
      </YStack>
    </XStack>
  );
}

export default TableHeader;
