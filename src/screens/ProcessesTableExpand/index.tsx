import React from 'react';
import {ScrollView} from 'react-native';
import {useRoute, RouteProp} from '@react-navigation/native';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import ProcessesTableExpand from './ProcessesTableExpand';
import Window from '../../components/Window';

type ProcessesTableExpandScreenRouteProp = RouteProp<
  RootStackParamList,
  'ProcessesTableExpand'
>;

function ProcessesTableExpandScreen(): JSX.Element {
  const route = useRoute<ProcessesTableExpandScreenRouteProp>();

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
    <Window title="Applications">
      <ScrollView>
        <ProcessesTableExpand data={tableData} />
      </ScrollView>
    </Window>
  );
}

export default ProcessesTableExpandScreen;
