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

type FlowsTableScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'FlowsTable'
>;

type FlowsTableScreenRouteProp = RouteProp<RootStackParamList>;

const {ScarecrowNetwork} = NativeModules;

function Sidebar(): JSX.Element {
  const navigation = useNavigation<FlowsTableScreenNavigationProp>();
  const route = useRoute<FlowsTableScreenRouteProp>();

  const [countProcesses, setcountProcesses] = React.useState<number>(0);
  const [countFlows, setcountFlows] = React.useState<number>(0);
  const [countRules, setcountRules] = React.useState<number>(0);

  React.useEffect(() => {
    ScarecrowNetwork.countProcesses(null).then(setcountProcesses);
    ScarecrowNetwork.countFlows(null).then(setcountFlows);
    ScarecrowNetwork.countRules(null).then(setcountRules);
  }, []);

  return (
    <YStack width={360} backgroundColor="#1A1B1D">
      <Header title="Scarecrow is Active" color="$green10" />

      <YStack paddingHorizontal="$4">
        <SidebarItem
          onPress={() => navigation.navigate('ProcessesTable')}
          active={route.name === 'ProcessesTable'}
          title="Applications"
          icon={<AppWindow />}
          iconRightText={countProcesses}
        />

        <SidebarItem
          onPress={() => navigation.navigate('FlowsTable')}
          active={route.name === 'FlowsTable'}
          title="Hostnames"
          icon={<Globe2 />}
          iconRightText={countFlows}
        />

        <SidebarItem
          onPress={() => navigation.navigate('RulesTable')}
          active={route.name === 'RulesTable'}
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
