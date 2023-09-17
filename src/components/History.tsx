import React from 'react';
import {NativeEventEmitter, NativeModules} from 'react-native';
import {ListItem, Separator, YStack, SizableText} from 'tamagui';
import {ArrowUp, ArrowDown} from '@tamagui/lucide-icons';

const {ScarecrowNetwork} = NativeModules;
const eventEmitter = new NativeEventEmitter(ScarecrowNetwork);

type handleDataFromFlowEventPayload = {
  remoteEndpoint: string;
  url: string;
  direction: string;
  localizedName: string;
  bundleIdentifier: string;
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
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <YStack separator={<Separator />}>
      {history.map((item, index) => (
        <ListItem
          backgroundColor="$borderColor"
          title={item.remoteEndpoint}
          subTitle={
            <SizableText theme="alt1" size="$3">
              {item.localizedName} {item.bundleIdentifier}
            </SizableText>
          }
          key={index}
          icon={
            item.direction === 'outbound' ? (
              <ArrowUp color="#0097e6" />
            ) : (
              <ArrowDown color="#44bd32" />
            )
          }>
          <SizableText theme="alt2" size="$3">
            {item.url}
          </SizableText>
        </ListItem>
      ))}
    </YStack>
  );
}

export default History;
