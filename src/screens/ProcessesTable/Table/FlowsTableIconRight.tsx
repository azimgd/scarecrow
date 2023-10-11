import React, {PropsWithChildren} from 'react';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import {Switch} from 'tamagui';

type FlowsTableIconRightProps = PropsWithChildren<{
  process: ScarecrowNetwork.ProcessModel;
  handleDataItemCheckedChange: (
    bundleIdentifier: string,
    checked: boolean,
  ) => void;
}>;

function FlowsTableIconRight({
  process,
  handleDataItemCheckedChange,
}: FlowsTableIconRightProps): JSX.Element {
  return (
    <Switch
      size="$2"
      defaultChecked={process.allowed}
      onCheckedChange={(checked: boolean) =>
        handleDataItemCheckedChange(process.bundle, checked)
      }>
      <Switch.Thumb animation="quick" />
    </Switch>
  );
}

export default FlowsTableIconRight;
