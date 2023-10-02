import React from 'react';
import {NativeModules} from 'react-native';
import {View, YStack, ListItem, Button, Text} from 'tamagui';
import {AppWindow, Globe2, ListFilter, CheckCircle2, AlertCircle} from '@tamagui/lucide-icons';

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
    <YStack width={360} space="$2">
      <YStack>
        <ListItem
          backgroundColor="$colorTransparent"
          borderBottomColor="$borderColor"
          borderBottomWidth="$0.25"
          iconAfter={<ListFilter />}>
          <Text color="#cccccc">View by</Text>
        </ListItem>

        <ListItem
          backgroundColor="$colorTransparent"
          title="Applications"
          icon={<AppWindow />}
          iconAfter={
            <Text color="#cccccc" fontSize="$2">
              50
            </Text>
          }
        />
        <ListItem
          backgroundColor="$colorTransparent"
          title="Hostnames"
          icon={<Globe2 />}
          iconAfter={
            <Text color="#cccccc" fontSize="$2">
              50
            </Text>
          }
        />
      </YStack>

      <YStack>
        <ListItem
          backgroundColor="$colorTransparent"
          borderBottomColor="$borderColor"
          borderBottomWidth="$0.25"
          iconAfter={<ListFilter />}>
          <Text color="#cccccc">Rules</Text>
        </ListItem>

        <ListItem
          backgroundColor="$colorTransparent"
          title="Global"
          icon={<CheckCircle2 />}
          iconAfter={
            <Text color="#cccccc" fontSize="$2">
              50
            </Text>
          }
        />

        <ListItem
          backgroundColor="$colorTransparent"
          title="Temporary"
          icon={<AlertCircle />}
          iconAfter={
            <Text color="#cccccc" fontSize="$2">
              50
            </Text>
          }
        />
      </YStack>

      <YStack paddingHorizontal="$4" space="$4">
        <Button
          theme="active"
          onPress={handlePress}
          disabled={status === undefined}>
          {status === true ? 'Stop Scarecrow' : null}
          {status === false ? 'Start Scarecrow' : null}
          {status === undefined ? 'Loading' : null}
        </Button>

        {status !== false ? (
          <Text fontSize="$2">
            You need to allow system extension under Preferences - Privacy &
            Security
          </Text>
        ) : null}
      </YStack>
    </YStack>
  );
}

export default Sidebar;
