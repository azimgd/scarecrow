import React from 'react';
import {NativeModules} from 'react-native';
import {useNavigation, useRoute, RouteProp} from '@react-navigation/native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../../navigation/index';
import {YStack, Button, Text} from 'tamagui';

type FlowsPerHostnameScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'FlowsPerHostname'
>;

type FlowsPerHostnameScreenRouteProp = RouteProp<
  RootStackParamList,
  'FlowsPerHostname'
>;

const {ScarecrowNetwork} = NativeModules;

function Splash(): JSX.Element {
  const navigation = useNavigation<FlowsPerHostnameScreenNavigationProp>();
  const route = useRoute<FlowsPerHostnameScreenRouteProp>();

  const [status, setStatus] = React.useState<boolean | undefined>(false);

  React.useEffect(() => {
    ScarecrowNetwork.getStatus().then(setStatus);
  }, []);

  React.useEffect(() => {
    if (status) {
      navigation.navigate('FlowsPerProcess');
    }
  }, [navigation, status]);

  const handlePress = React.useCallback(() => {
    setStatus(undefined);

    ScarecrowNetwork.getStatus().then((status: boolean) => {
      if (status) {
        ScarecrowNetwork.deactivate().then(setStatus);
      } else {
        ScarecrowNetwork.activate().then(setStatus);
      }
    });
  }, []);

  return (
    <YStack padding="$4" space="$4" justifyContent="center" alignItems="center">
      <Button
        backgroundColor="$blue10"
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
  );
}

export default Splash;
