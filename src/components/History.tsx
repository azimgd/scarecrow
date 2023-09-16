import React from 'react';
import {NativeEventEmitter, NativeModules} from 'react-native';
import {ListItem, Separator, YStack} from 'tamagui';

const {ScarecrowNetwork} = NativeModules;
const eventEmitter = new NativeEventEmitter(ScarecrowNetwork);

function History(): JSX.Element {
  const [history, setHistory] = React.useState<string[]>([]);

  const logger = React.useCallback((event: string) => {
    setHistory(state => state.concat([event]));
  }, []);

  React.useEffect(() => {
    const subscription = eventEmitter.addListener('logger', logger);
    return () => subscription.remove();
  }, [logger]);

  return (
    <YStack separator={<Separator />}>
      {history.map((item, index) => (
        <ListItem title={item} subTitle="Twinkles" key={index} />
      ))}
    </YStack>
  );
}

export default History;
