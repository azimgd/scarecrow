import React from 'react';
import {ScrollView} from 'react-native';
import {useRoute, RouteProp} from '@react-navigation/native';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowsTableExpand from './FlowsTableExpand';
import Window from '../../components/Window';

type FlowsTableExpandScreenRouteProp = RouteProp<
  RootStackParamList,
  'FlowsTableExpand'
>;

function FlowsTableExpandScreen(): JSX.Element {
  const route = useRoute<FlowsTableExpandScreenRouteProp>();

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
        <FlowsTableExpand data={tableData} />
      </ScrollView>
    </Window>
  );
}

export default FlowsTableExpandScreen;
