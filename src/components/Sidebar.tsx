import React from 'react';
import {NativeModules} from 'react-native';
import {View, YStack, ListItem, Button} from 'tamagui';
import {ArrowUp} from '@tamagui/lucide-icons';

const {ScarecrowNetwork} = NativeModules;

function Sidebar(): JSX.Element {
  const [status, setStatus] = React.useState<boolean>(false);

  const requestStatus = React.useCallback(() => {
    ScarecrowNetwork.isEnabled().then((status: boolean) => {
      setStatus(status);
    });
  }, []);

  React.useEffect(() => {
    requestStatus();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handlePress = React.useCallback(() => {
    ScarecrowNetwork.isEnabled().then((status: boolean) => {
      if (status) {
        ScarecrowNetwork.disable();
      } else {
        ScarecrowNetwork.enable();
      }

      setStatus(!status);
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <YStack minWidth={360}>
      <ListItem title="All Requests" icon={<ArrowUp color="#0097e6" />} />
      <ListItem title="HTTPS Requests" icon={<ArrowUp color="#0097e6" />} />

      <View paddingHorizontal="$4">
        <Button theme="active" onPress={handlePress}>
          {status ? 'Stop Scarecrow' : 'Start Scarecrow'}
        </Button>
      </View>
    </YStack>
  );
}

export default Sidebar;
