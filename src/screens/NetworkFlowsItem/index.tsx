import React from 'react';
import {ScrollView} from 'react-native';
import {useRoute, RouteProp} from '@react-navigation/native';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import NetworkFlowsItemTable from './NetworkFlowsItemTable';

type NetworkFlowsItemScreenRouteProp = RouteProp<
  RootStackParamList,
  'NetworkFlowsItem'
>;

function NetworkFlowsItem(): JSX.Element {
  const route = useRoute<NetworkFlowsItemScreenRouteProp>();

  const [tableData, setTableData] = React.useState<
    ScarecrowNetwork.handleDataFromFlowEventPayload[]
  >([]);

  const handleDataFromFlowEvent = React.useCallback(
    (event: {string: ScarecrowNetwork.handleDataFromFlowEventPayload}) => {
      setTableData(Object.values(event));
    },
    [],
  );

  React.useEffect(() => {
    ScarecrowNetwork.getFlowsByBundleIdentifier(
      route.params.bundleIdentifier,
    ).then(handleDataFromFlowEvent);

    const subscription = ScarecrowNetwork.handleDataFromFlowEvent(
      handleDataFromFlowEvent,
    );
    return () => subscription.remove();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <ScrollView>
      <NetworkFlowsItemTable data={tableData} />
    </ScrollView>
  );
}

export default NetworkFlowsItem;
