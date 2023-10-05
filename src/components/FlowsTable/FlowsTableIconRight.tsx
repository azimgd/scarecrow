import React, {PropsWithChildren} from 'react';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import {Switch} from 'tamagui';

type FlowsTableIconRightProps = PropsWithChildren<{
  flow: ScarecrowNetwork.handleDataFromFlowEventPayload;
  handleDataItemCheckedChange: (
    bundleIdentifier: string,
    checked: boolean,
  ) => void;
}>;

function FlowsTableIconRight({
  flow,
  handleDataItemCheckedChange,
}: FlowsTableIconRightProps): JSX.Element {
  return (
    <Switch
      size="$2"
      defaultChecked={flow.allowed}
      onCheckedChange={(checked: boolean) =>
        handleDataItemCheckedChange(flow.bundleIdentifier, checked)
      }>
      <Switch.Thumb animation="quick" />
    </Switch>
  );
}

export default FlowsTableIconRight;
