import React, {PropsWithChildren} from 'react';
import {Image} from 'react-native';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import {AppWindow} from '@tamagui/lucide-icons';

type FlowsTableIconLeftProps = PropsWithChildren<{
  process: ScarecrowNetwork.ProcessModel;
}>;

function FlowsTableIconLeft({process}: FlowsTableIconLeftProps): JSX.Element {
  return process.icon ? (
    <Image source={{uri: process.icon}} width={20} height={20} />
  ) : (
    <AppWindow width={20} height={20} strokeWidth={1.5} />
  );
}

export default FlowsTableIconLeft;
