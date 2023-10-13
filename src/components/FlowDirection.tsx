import React, {PropsWithChildren} from 'react';
import {ArrowDown, ArrowUp} from '@tamagui/lucide-icons';
import * as ScarecrowNetwork from '../ScarecrowNetwork';

type FlowDirectionProps = PropsWithChildren<{
  flow: ScarecrowNetwork.FlowModel;
  width: number;
}>;

function FlowDirection({flow, width}: FlowDirectionProps): JSX.Element {
  return flow.direction === 'inbound' ? (
    <ArrowDown width={width} height={width} color="$green10" />
  ) : (
    <ArrowUp width={width} height={width} color="$blue10" />
  );
}

export default FlowDirection;
