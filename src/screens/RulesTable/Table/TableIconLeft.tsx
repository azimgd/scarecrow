import React, {PropsWithChildren} from 'react';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import {StopCircle} from '@tamagui/lucide-icons';

type RulesTableIconLeftProps = PropsWithChildren<{
  rule: ScarecrowNetwork.RuleModel;
}>;

function RulesTableIconLeft({rule}: RulesTableIconLeftProps): JSX.Element {
  return <StopCircle color="#44bd32" />;
}

export default RulesTableIconLeft;
