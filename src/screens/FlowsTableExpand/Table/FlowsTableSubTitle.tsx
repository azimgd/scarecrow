import React, {PropsWithChildren} from 'react';
import {SizableText, XStack} from 'tamagui';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';

type FlowsTableSubTitleProps = PropsWithChildren<{
  flow: ScarecrowNetwork.FlowModel;
}>;

function FlowsTableSubTitle({flow}: FlowsTableSubTitleProps): JSX.Element {
  return (
    <XStack space="$2">
      <SizableText theme="alt1" size="$3">
        {flow.process.bundle}
      </SizableText>
    </XStack>
  );
}

export default FlowsTableSubTitle;
