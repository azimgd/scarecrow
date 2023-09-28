import React from 'react';
import {NativeModules} from 'react-native';
import {View, YStack, ListItem, Button, Text} from 'tamagui';
import {ArrowUp} from '@tamagui/lucide-icons';

const {ScarecrowNetwork} = NativeModules;

function Sidebar(): JSX.Element {
  const [status, setStatus] = React.useState<boolean | undefined>(false);

  const requestStatus = React.useCallback(() => {
    ScarecrowNetwork.getStatus().then(setStatus);
  }, []);

  React.useEffect(() => {
    requestStatus();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handlePress = React.useCallback(() => {
    setStatus(undefined);

    ScarecrowNetwork.getStatus().then((status: boolean) => {
      if (status) {
        ScarecrowNetwork.deactivate().then(setStatus);
      } else {
        ScarecrowNetwork.activate().then(setStatus);
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
          {status === true ? 'Stop Scarecrow' : null}
          {status === false ? 'Start Scarecrow' : null}
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
