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

  const [countProcesses, setcountProcesses] = React.useState<number>(0);
  const [countFlows, setcountFlows] = React.useState<number>(0);
  const [countRules, setcountRules] = React.useState<number>(0);

  React.useEffect(() => {
    ScarecrowNetwork.countProcesses().then(setcountProcesses);
    ScarecrowNetwork.countFlows().then(setcountFlows);
    ScarecrowNetwork.countRules().then(setcountRules);
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
          iconRightText={countProcesses}
        />

        <SidebarItem
          onPress={() => navigation.navigate('FlowsPerHostname')}
          active={route.name === 'FlowsPerHostname'}
          title="Hostnames"
          icon={<Globe2 />}
          iconRightText={countFlows}
        />

        <SidebarItem
          onPress={() => navigation.navigate('FlowRules')}
          active={route.name === 'FlowRules'}
          title="Rules"
          icon={<Ruler />}
          iconRightText={countRules}
        />
      </YStack>

      <YStack flex={1} justifyContent="flex-end">
        <Environment />
      </YStack>
    </YStack>
  );
}

export default Sidebar;
