import React, {PropsWithChildren} from 'react';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import {ArrowUp, ArrowDown} from '@tamagui/lucide-icons';

type FlowsTableIconLeftProps = PropsWithChildren<{
  flow: ScarecrowNetwork.handleDataFromFlowEventPayload;
}>;

function FlowsTableIconLeft({flow}: FlowsTableIconLeftProps): JSX.Element {
  // flow.image ? (
  //   <Image
  //     source={{uri: `data:image/png;base64,${flow.image}`}}
  //     width={20}
  //     height={20}
  //   />
  // ) : (
  //   <AppWindow width={20} height={20} strokeWidth={1.5} />
  // )

  return flow.direction === 'outbound' ? (
    <ArrowUp color="#0097e6" />
  ) : (
    <ArrowDown color="#44bd32" />
  );
}

export default FlowsTableIconLeft;
