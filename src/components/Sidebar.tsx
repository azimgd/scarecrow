import React from 'react';
import {NativeModules} from 'react-native';
import {useNavigation, useRoute, RouteProp} from '@react-navigation/native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../navigation/index';
import {YStack} from 'tamagui';
import {AppWindow, Globe2, Ruler} from '@tamagui/lucide-icons';
import Environment from './Environment';
import SidebarItem from './SidebarItem';
import Header from './Header';

type FlowsPerHostnameScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'FlowsPerHostname'
>;

type FlowsPerHostnameScreenRouteProp = RouteProp<RootStackParamList>;

const {ScarecrowNetwork} = NativeModules;

function Sidebar(): JSX.Element {
  const navigation = useNavigation<FlowsPerHostnameScreenNavigationProp>();
  const route = useRoute<FlowsPerHostnameScreenRouteProp>();

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
    <YStack width={360} backgroundColor="#1A1B1D">
      <Header title="Scarecrow is Active" color="$green10" />

      <YStack paddingHorizontal="$4">
        <SidebarItem
          onPress={() => navigation.navigate('FlowsPerProcess')}
          active={route.name === 'FlowsPerProcess'}
          title="Applications"
          icon={<AppWindow />}
          iconRightText={countGrouppedFlowsByBundleIdentifier}
        />

        <SidebarItem
          onPress={() => navigation.navigate('FlowsPerHostname')}
          active={route.name === 'FlowsPerHostname'}
          title="Hostnames"
          icon={<Globe2 />}
          iconRightText={countGrouppedFlowsByRemoteEndpoint}
        />

        <SidebarItem
          onPress={() => navigation.navigate('FlowRules')}
          active={route.name === 'FlowRules'}
          title="Rules"
          icon={<Ruler />}
          iconRightText={countGrouppedFlowsByBundleIdentifier}
        />
      </YStack>

      <YStack flex={1} justifyContent="flex-end">
        <Environment />
      </YStack>
    </YStack>
  );
}

export default Sidebar;
