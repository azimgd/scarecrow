import React, {PropsWithChildren} from 'react';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import {StopCircle} from '@tamagui/lucide-icons';

type TableIconLeftProps = PropsWithChildren<{
  rule: ScarecrowNetwork.RuleModel;
}>;

function TableIconLeft({rule}: TableIconLeftProps): JSX.Element {
  return (
    <StopCircle color="#44bd32" width={20} height={20} strokeWidth={1.5} />
  );
}

export default TableIconLeft;
