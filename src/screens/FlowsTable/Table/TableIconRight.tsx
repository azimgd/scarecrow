import React, {PropsWithChildren} from 'react';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import {ArrowRight} from '@tamagui/lucide-icons';

type TableIconRightProps = PropsWithChildren<{
  flow: ScarecrowNetwork.FlowModel;
}>;

function TableIconRight({flow}: TableIconRightProps): JSX.Element {
  return <ArrowRight width={20} height={20} strokeWidth={1.5} />;
}

export default TableIconRight;
