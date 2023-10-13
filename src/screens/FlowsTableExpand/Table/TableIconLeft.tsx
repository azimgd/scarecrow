import React, {PropsWithChildren} from 'react';
import {Image} from 'react-native';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import {AppWindow} from '@tamagui/lucide-icons';

type TableIconLeftProps = PropsWithChildren<{
  flow: ScarecrowNetwork.FlowModel;
}>;

function TableIconLeft({flow}: TableIconLeftProps): JSX.Element {
  return flow.process.icon ? (
    <Image source={{uri: flow.process.icon}} width={20} height={20} />
  ) : (
    <AppWindow width={20} height={20} strokeWidth={1.5} />
  );
}

export default TableIconLeft;
