import React from 'react';
import {NativeModules} from 'react-native';
import {useNavigation, useRoute, RouteProp} from '@react-navigation/native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../../navigation/index';
import {YStack, Button, Text} from 'tamagui';

type FlowsTableScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'FlowsTable'
>;

type FlowsTableScreenRouteProp = RouteProp<
  RootStackParamList,
  'FlowsTable'
>;

const {ScarecrowNetwork} = NativeModules;

function SplashScreen(): JSX.Element {
  const navigation = useNavigation<FlowsTableScreenNavigationProp>();
  const route = useRoute<FlowsTableScreenRouteProp>();

  const [status, setStatus] = React.useState<boolean | undefined>(false);

  React.useEffect(() => {
    ScarecrowNetwork.handleExtensionStatusRequest().then(setStatus);
  }, []);

  React.useEffect(() => {
    if (status) {
      navigation.navigate('ProcessesTable');
    }
  }, [navigation, status]);

  const handlePress = React.useCallback(() => {
    setStatus(undefined);

    ScarecrowNetwork.handleExtensionStatusRequest().then((status: boolean) => {
      if (status) {
        ScarecrowNetwork.handleExtensionStop().then(setStatus);
      } else {
        ScarecrowNetwork.handleExtensionStart().then(setStatus);
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

export default SplashScreen;
