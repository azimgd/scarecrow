import React from 'react';
import {ScrollView} from 'react-native';
import {useNavigation} from '@react-navigation/native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import ProcessesTable from './ProcessesTable';
import Window from '../../components/Window';
import SearchBar from '../../components/Searchbar';

type ProcessesTableScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'ProcessesTable'
>;

function ProcessesTableScreen(): JSX.Element {
  const navigation = useNavigation<ProcessesTableScreenNavigationProp>();

  const [tableData, setTableData] = React.useState<
    ScarecrowNetwork.ProcessModel[]
  >([]);

  const handleDataItemPress = React.useCallback((id: number) => {
    navigation.navigate('ProcessesTableExpand', {processId: id});
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleDataItemCheckedChange = React.useCallback(
    (bundleIdentifier: string, checked: boolean) => {
      ScarecrowNetwork.handleFlowRuleUpdate(bundleIdentifier, checked);
    },
    [],
  );

  React.useEffect(() => {
    ScarecrowNetwork.getProcesses(null).then(setTableData);
    const listener = ScarecrowNetwork.handleFlowRequest(() =>
      ScarecrowNetwork.getProcesses(null).then(setTableData),
    );

    return () => listener.remove();
  }, []);

  return (
    <Window title="Applications">
      <ScrollView>
        <SearchBar />

        <ProcessesTable
          data={tableData}
          handleDataItemPress={handleDataItemPress}
          handleDataItemCheckedChange={handleDataItemCheckedChange}
        />
      </ScrollView>
    </Window>
  );
}

export default ProcessesTableScreen;
