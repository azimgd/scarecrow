import React from 'react';
import {ScrollView, EmitterSubscription} from 'react-native';
import {useNavigation, useRoute, RouteProp} from '@react-navigation/native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import NetworkFlowsTable from './NetworkFlowsTable';
import Window from '../../components/Window';

type NetworkFlowsScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'NetworkFlows'
>;

type NetworkFlowsScreenRouteProp = RouteProp<
  RootStackParamList,
  'NetworkFlows'
>;

function NetworkFlows(): JSX.Element {
  const navigation = useNavigation<NetworkFlowsScreenNavigationProp>();
  const route = useRoute<NetworkFlowsScreenRouteProp>();

  const [tableData, setTableData] = React.useState<
    ScarecrowNetwork.handleDataFromFlowEventPayload[]
  >([]);

  const handleDataItemPress = React.useCallback((bundleIdentifier: string) => {
    navigation.navigate('NetworkFlowsItem', {bundleIdentifier});
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleDataItemCheckedChange = React.useCallback(
    (bundleIdentifier: string, checked: boolean) => {
      ScarecrowNetwork.updateFlowRule(bundleIdentifier, checked);
    },
    [],
  );

  React.useEffect(() => {
    let listener: EmitterSubscription;

    if (route.params?.viewBy === 'bundleIdentifier') {
      ScarecrowNetwork.getGrouppedFlowsByBundleIdentifier().then(setTableData);
      listener = ScarecrowNetwork.handleDataFromFlowEvent(() =>
        ScarecrowNetwork.getGrouppedFlowsByBundleIdentifier().then(
          setTableData,
        ),
      );
    }

    if (route.params?.viewBy === 'remoteEndpoint') {
      ScarecrowNetwork.getGrouppedFlowsByRemoteEndpoint().then(setTableData);
      listener = ScarecrowNetwork.handleDataFromFlowEvent(() =>
        ScarecrowNetwork.getGrouppedFlowsByRemoteEndpoint().then(setTableData),
      );
    }

    return () => listener.remove();
  }, [route.params?.viewBy]);

  return (
    <Window title="View by Applications">
      <ScrollView>
        <NetworkFlowsTable
          data={tableData}
          handleDataItemPress={handleDataItemPress}
          handleDataItemCheckedChange={handleDataItemCheckedChange}
        />
      </ScrollView>
    </Window>
  );
}

export default NetworkFlows;
