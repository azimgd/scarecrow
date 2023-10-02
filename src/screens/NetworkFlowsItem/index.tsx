import React from 'react';
import {ScrollView} from 'react-native';
import {useRoute, RouteProp} from '@react-navigation/native';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import NetworkFlowsItemTable from './NetworkFlowsItemTable';
import Window from '../../components/Window';

type NetworkFlowsItemScreenRouteProp = RouteProp<
  RootStackParamList,
  'NetworkFlowsItem'
>;

function NetworkFlowsItem(): JSX.Element {
  const route = useRoute<NetworkFlowsItemScreenRouteProp>();

  const [tableData, setTableData] = React.useState<
    ScarecrowNetwork.handleDataFromFlowEventPayload[]
  >([]);

  React.useEffect(() => {
    ScarecrowNetwork.getFlowsByBundleIdentifier(
      route.params.bundleIdentifier,
    ).then(setTableData);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <Window title="View by Applications">
      <ScrollView>
        <NetworkFlowsItemTable data={tableData} />
      </ScrollView>
    </Window>
  );
}

export default NetworkFlowsItem;
