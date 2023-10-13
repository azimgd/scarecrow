import React, {PropsWithChildren} from 'react';
import {SizableText, XStack} from 'tamagui';
import dayjs from 'dayjs';
import * as ScarecrowNetwork from '../../../ScarecrowNetwork';

type TableSubTitleProps = PropsWithChildren<{
  flow: ScarecrowNetwork.FlowModel;
}>;

function TableSubTitle({flow}: TableSubTitleProps): JSX.Element {
  return (
    <XStack space="$2">
      <SizableText theme="alt1" size="$3">
        {flow.process.bundle} {dayjs.unix(flow.createdAt).fromNow()}
      </SizableText>
    </XStack>
  );
}

export default TableSubTitle;
