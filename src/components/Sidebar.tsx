import React from 'react';
import {NativeModules} from 'react-native';
import {View, YStack, ListItem, Button, Text} from 'tamagui';
import {ArrowUp} from '@tamagui/lucide-icons';

const {ScarecrowNetwork} = NativeModules;

function Sidebar(): JSX.Element {
  const [status, setStatus] = React.useState<boolean | undefined>(false);

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
    setStatus(undefined);

    ScarecrowNetwork.isEnabled().then((status: boolean) => {
      if (status) {
        ScarecrowNetwork.disable().then((status: boolean) => {
          setStatus(status);
        });
      } else {
        ScarecrowNetwork.enable().then((status: boolean) => {
          setStatus(status);
        });
      }
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <YStack width={360}>
      <ListItem title="All Requests" icon={<ArrowUp color="#0097e6" />} />
      <ListItem title="HTTPS Requests" icon={<ArrowUp color="#0097e6" />} />

      <View paddingHorizontal="$4">
        <Button
          theme="active"
          onPress={handlePress}
          disabled={status === undefined}>
          {status === true ? 'Start Scarecrow' : null}
          {status === false ? 'Stop Scarecrow' : null}
          {status === undefined ? 'Loading' : null}
        </Button>

        {status !== false ? (
          <Text paddingTop="$4">
            You need to allow system extension under Preferences - Privacy &
            Security
          </Text>
        ) : null}
      </View>
    </YStack>
  );
}

export default Sidebar;
