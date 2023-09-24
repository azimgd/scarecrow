import React from 'react';
import {ScrollView} from 'react-native';
import {useNavigation} from '@react-navigation/native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import NetworkFlowsTable from './NetworkFlowsTable';

type NetworkFlowsScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'NetworkFlows'
>;

function NetworkFlows(): JSX.Element {
  const navigation = useNavigation<NetworkFlowsScreenNavigationProp>();

  const [tableData, setTableData] = React.useState<
    ScarecrowNetwork.handleDataFromFlowEventPayload[]
  >([]);

  const handleDataFromFlowEvent = React.useCallback(
    (event: {string: ScarecrowNetwork.handleDataFromFlowEventPayload}) => {
      setTableData(Object.values(event));
    },
    [],
  );

  const handleDataItemPress = React.useCallback((bundleIdentifier: string) => {
    navigation.navigate('NetworkFlowsItem', {bundleIdentifier});
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleDataItemCheckedChange = React.useCallback(
    (bundleIdentifier: string, checked: boolean) => {
      checked;
      ScarecrowNetwork.toggleFlowRule(bundleIdentifier);
    },
    [],
  );

  React.useEffect(() => {
    ScarecrowNetwork.getGrouppedFlows().then(handleDataFromFlowEvent);

    const subscription = ScarecrowNetwork.handleDataFromFlowEvent(
      handleDataFromFlowEvent,
    );
    return () => subscription.remove();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <ScrollView>
      <NetworkFlowsTable
        data={tableData}
        handleDataItemPress={handleDataItemPress}
        handleDataItemCheckedChange={handleDataItemCheckedChange}
      />
    </ScrollView>
  );
}

export default NetworkFlows;
