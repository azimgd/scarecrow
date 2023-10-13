import React, {PropsWithChildren} from 'react';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';
import {Switch} from 'tamagui';

type TableIconRightProps = PropsWithChildren<{
  rule: ScarecrowNetwork.RuleModel;
  handleDataItemCheckedChange: (
    bundleIdentifier: string,
    checked: boolean,
  ) => void;
}>;

function TableIconRight({
  rule,
  handleDataItemCheckedChange,
}: TableIconRightProps): JSX.Element {
  return (
    <Switch
      size="$2"
      defaultChecked={rule.allowed}
      onCheckedChange={(checked: boolean) =>
        handleDataItemCheckedChange(rule.process.bundle, checked)
      }>
      <Switch.Thumb animation="quick" />
    </Switch>
  );
}

export default TableIconRight;
