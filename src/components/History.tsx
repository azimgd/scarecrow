import React from 'react';
import {NativeEventEmitter, NativeModules} from 'react-native';
import {ListItem, Separator, YStack} from 'tamagui';
import {ArrowUp, ArrowDown} from '@tamagui/lucide-icons';

const {ScarecrowNetwork} = NativeModules;
const eventEmitter = new NativeEventEmitter(ScarecrowNetwork);

type handleDataFromFlowEventPayload = {
  remoteEndpoint: string;
  url: string;
  direction: string;
};

function History(): JSX.Element {
  const [history, setHistory] = React.useState<
    handleDataFromFlowEventPayload[]
  >([]);

  const handleDataFromFlowEvent = React.useCallback(
    (event: handleDataFromFlowEventPayload) => {
      setHistory(state => state.concat([event]));
    },
    [],
  );

  React.useEffect(() => {
    const subscription = eventEmitter.addListener(
      'handleDataFromFlowEvent',
      handleDataFromFlowEvent,
    );
    return () => subscription.remove();
  }, [handleDataFromFlowEvent]);

  return (
    <YStack separator={<Separator />}>
      {history.map((item, index) => (
        <ListItem
          title={item.remoteEndpoint}
          subTitle={item.url}
          key={index}
          icon={item.direction === 'outbound' ? ArrowUp : ArrowDown}
        />
      ))}
    </YStack>
  );
}

export default History;
