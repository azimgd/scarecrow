import React, {PropsWithChildren} from 'react';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import ProcessImage from '../../../components/ProcessImage';

type TableIconLeftProps = PropsWithChildren<{
  process: ScarecrowNetwork.ProcessModel;
}>;

function TableIconLeft({process}: TableIconLeftProps): JSX.Element {
  return <ProcessImage process={process} />;
}

export default TableIconLeft;
