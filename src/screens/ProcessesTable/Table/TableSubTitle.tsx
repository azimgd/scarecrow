import React, {PropsWithChildren} from 'react';
import {SizableText, XStack} from 'tamagui';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';

type FlowsTableSubTitleProps = PropsWithChildren<{
  process: ScarecrowNetwork.ProcessModel;
}>;

function FlowsTableSubTitle({process}: FlowsTableSubTitleProps): JSX.Element {
  return (
    <XStack space="$2">
      <SizableText theme="alt1" size="$3">
        {process.bundle}
      </SizableText>
    </XStack>
  );
}

export default FlowsTableSubTitle;
