import React, {PropsWithChildren} from 'react';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import ProcessImage from '../../../components/ProcessImage';

type TableIconLeftProps = PropsWithChildren<{
  flow: ScarecrowNetwork.FlowModel;
}>;

function TableIconLeft({flow}: TableIconLeftProps): JSX.Element {
  return <ProcessImage process={flow.process} />;
}

export default TableIconLeft;
