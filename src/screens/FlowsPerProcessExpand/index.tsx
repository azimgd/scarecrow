import React from 'react';
import {ScrollView} from 'react-native';
import {useRoute, RouteProp} from '@react-navigation/native';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowsPerProcessExpandTable from './FlowsPerProcessExpandTable';
import Window from '../../components/Window';

type FlowsPerProcessExpandScreenRouteProp = RouteProp<
  RootStackParamList,
  'FlowsPerProcessExpand'
>;

function FlowsPerProcessExpand(): JSX.Element {
  const route = useRoute<FlowsPerProcessExpandScreenRouteProp>();

  const [tableData, setTableData] = React.useState<
    ScarecrowNetwork.handleFlowRequestPayload[]
  >([]);

  React.useEffect(() => {
    ScarecrowNetwork.getProcesses(route.params.bundleIdentifier).then(
      setTableData,
    );
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <Window title="Applications">
      <ScrollView>
        <FlowsPerProcessExpandTable data={tableData} />
      </ScrollView>
    </Window>
  );
}

export default FlowsPerProcessExpand;
