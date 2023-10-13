import React, {PropsWithChildren} from 'react';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import {ArrowDown, ArrowUp} from '@tamagui/lucide-icons';

type TableIconLeftProps = PropsWithChildren<{
  flow: ScarecrowNetwork.FlowModel;
}>;

function TableIconLeft({flow}: TableIconLeftProps): JSX.Element {
  return flow.direction === 'inbound' ? (
    <ArrowDown width={20} height={20} strokeWidth={1.5} color="$green10" />
  ) : (
    <ArrowUp width={20} height={20} strokeWidth={1.5} color="$blue10" />
  );
}

export default TableIconLeft;
