import React from 'react';
import {ScrollView} from 'react-native';
import {useNavigation} from '@react-navigation/native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowsPerProcessTable from './FlowsPerProcessTable';
import Window from '../../components/Window';
import SearchBar from '../../components/Searchbar';

type FlowsPerProcessScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'FlowsPerProcess'
>;

function FlowsPerProcess(): JSX.Element {
  const navigation = useNavigation<FlowsPerProcessScreenNavigationProp>();

  const [tableData, setTableData] = React.useState<
    ScarecrowNetwork.ProcessModel[]
  >([]);

  const handleDataItemPress = React.useCallback((bundleIdentifier: string) => {
    navigation.navigate('FlowsPerProcessExpand', {bundleIdentifier});
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

        <FlowsPerProcessTable
          data={tableData}
          handleDataItemPress={handleDataItemPress}
          handleDataItemCheckedChange={handleDataItemCheckedChange}
        />
      </ScrollView>
    </Window>
  );
}

export default FlowsPerProcess;
