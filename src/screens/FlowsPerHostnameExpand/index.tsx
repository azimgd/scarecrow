import React from 'react';
import {ScrollView} from 'react-native';
import {useRoute, RouteProp} from '@react-navigation/native';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowsPerHostnameExpandTable from './FlowsPerHostnameExpandTable';
import Window from '../../components/Window';

type FlowsPerHostnameExpandScreenRouteProp = RouteProp<
  RootStackParamList,
  'FlowsPerHostnameExpand'
>;

function FlowsPerHostnameExpand(): JSX.Element {
  const route = useRoute<FlowsPerHostnameExpandScreenRouteProp>();

  const [tableData, setTableData] = React.useState<
    ScarecrowNetwork.ProcessModel[]
  >([]);

  React.useEffect(() => {
    ScarecrowNetwork.getProcesses(route.params.bundleIdentifier).then(
      setTableData,
    );
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <Window title="Endpoints">
      <ScrollView>
        <FlowsPerHostnameExpandTable data={tableData} />
      </ScrollView>
    </Window>
  );
}

export default FlowsPerHostnameExpand;
