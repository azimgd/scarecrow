import React, {PropsWithChildren} from 'react';
import {Image} from 'react-native';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import {ArrowUp, ArrowDown} from '@tamagui/lucide-icons';
import {AppWindow} from '@tamagui/lucide-icons';

type FlowsTableIconLeftProps = PropsWithChildren<{
  flow: ScarecrowNetwork.handleFlowRequestPayload;
  type?: 'process' | 'hostname' | 'default';
}>;

function FlowsTableIconLeftHostname({
  flow,
}: FlowsTableIconLeftProps): JSX.Element {
  return flow.icon ? (
    <Image source={{uri: flow.icon}} width={20} height={20} />
  ) : (
    <AppWindow width={20} height={20} strokeWidth={1.5} />
  );
}

function FlowsTableIconLeftProcess({
  flow,
}: FlowsTableIconLeftProps): JSX.Element {
  return flow.direction === 'outbound' ? (
    <ArrowUp color="$blue8" />
  ) : (
    <ArrowDown color="$green8" />
  );
}

function FlowsTableIconLeftDefault({
  flow,
}: FlowsTableIconLeftProps): JSX.Element {
  return flow.direction === 'outbound' ? (
    <ArrowUp color="$blue8" />
  ) : (
    <ArrowDown color="$green8" />
  );
}

function FlowsTableIconLeft({
  flow,
  type,
}: FlowsTableIconLeftProps): JSX.Element {
  if (type === 'hostname') {
    return <FlowsTableIconLeftProcess flow={flow} />;
  }
  if (type === 'process') {
    return <FlowsTableIconLeftHostname flow={flow} />;
  }
  return <FlowsTableIconLeftDefault flow={flow} />;
}

export default FlowsTableIconLeft;
