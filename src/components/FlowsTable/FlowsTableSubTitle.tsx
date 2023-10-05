import React, {PropsWithChildren} from 'react';
import {SizableText} from 'tamagui';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';

type FlowsTableSubTitleProps = PropsWithChildren<{
  flow: ScarecrowNetwork.handleDataFromFlowEventPayload;
}>;

function FlowsTableSubTitle({flow}: FlowsTableSubTitleProps): JSX.Element {
  return (
    <SizableText theme="alt1" size="$3">
      {flow.remoteEndpoint} {(flow.totalSize / 1024).toFixed(2)} kb {flow.totalCount} items
    </SizableText>
  );
}

export default FlowsTableSubTitle;
