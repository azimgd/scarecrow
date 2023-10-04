import React from 'react';
import {NativeModules} from 'react-native';
import {useNavigation, useRoute, RouteProp} from '@react-navigation/native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../navigation/index';
import {YStack, ListItem, Text} from 'tamagui';
import {
  AppWindow,
  Globe2,
  ListFilter,
  CheckCircle2,
  AlertCircle,
} from '@tamagui/lucide-icons';

type NetworkFlowsScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'NetworkFlows'
>;

type NetworkFlowsScreenRouteProp = RouteProp<
  RootStackParamList,
  'NetworkFlows'
>;

const {ScarecrowNetwork} = NativeModules;

function Sidebar(): JSX.Element {
  const navigation = useNavigation<NetworkFlowsScreenNavigationProp>();
  const route = useRoute<NetworkFlowsScreenRouteProp>();

  const [
    countGrouppedFlowsByBundleIdentifier,
    setCountGrouppedFlowsByBundleIdentifier,
  ] = React.useState<number>(0);
  const [
    countGrouppedFlowsByRemoteEndpoint,
    setCountGrouppedFlowsByRemoteEndpoint,
  ] = React.useState<number>(0);

  React.useEffect(() => {
    ScarecrowNetwork.countGrouppedFlowsByBundleIdentifier().then(
      setCountGrouppedFlowsByBundleIdentifier,
    );
    ScarecrowNetwork.countGrouppedFlowsByRemoteEndpoint().then(
      setCountGrouppedFlowsByRemoteEndpoint,
    );
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
          onPress={() =>
            navigation.navigate('NetworkFlows', {viewBy: 'bundleIdentifier'})
          }
          backgroundColor={
            route.params?.viewBy === 'bundleIdentifier'
              ? '$blue10'
              : '$colorTransparent'
          }
          title="Applications"
          icon={<AppWindow />}
          iconAfter={
            <Text color="#cccccc" fontSize="$2">
              {countGrouppedFlowsByBundleIdentifier}
            </Text>
          }
        />
        <ListItem
          onPress={() =>
            navigation.navigate('NetworkFlows', {viewBy: 'remoteEndpoint'})
          }
          backgroundColor={
            route.params?.viewBy === 'remoteEndpoint'
              ? '$blue10'
              : '$colorTransparent'
          }
          title="Hostnames"
          icon={<Globe2 />}
          iconAfter={
            <Text color="#cccccc" fontSize="$2">
              {countGrouppedFlowsByRemoteEndpoint}
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
          onPress={() => navigation.navigate('FlowRules')}
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
          onPress={() => navigation.navigate('FlowRules')}
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
    </YStack>
  );
}

export default Sidebar;
