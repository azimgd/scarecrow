import React, {PropsWithChildren} from 'react';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import FlowDirection from '../../../components/FlowDirection';

type TableIconLeftProps = PropsWithChildren<{
  flow: ScarecrowNetwork.FlowModel;
}>;

function TableIconLeft({flow}: TableIconLeftProps): JSX.Element {
  return <FlowDirection flow={flow} width={20} />;
}

export default TableIconLeft;
