import React, {PropsWithChildren} from 'react';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import {ArrowRight} from '@tamagui/lucide-icons';

type FlowsTableIconRightProps = PropsWithChildren<{
  flow: ScarecrowNetwork.FlowModel;
}>;

function FlowsTableIconRight({flow}: FlowsTableIconRightProps): JSX.Element {
  return <ArrowRight width={20} height={20} strokeWidth={1.5} />;
}

export default FlowsTableIconRight;
