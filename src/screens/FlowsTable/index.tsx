import React from 'react';
import {ScrollView} from 'react-native';
import {useNavigation} from '@react-navigation/native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowsTable from './FlowsTable';
import Window from '../../components/Window';
import SearchBar from '../../components/Searchbar';

type FlowsTableScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'FlowsTable'
>;

function FlowsTableScreen(): JSX.Element {
  const navigation = useNavigation<FlowsTableScreenNavigationProp>();

  const [tableData, setTableData] = React.useState<
    ScarecrowNetwork.FlowModel[]
  >([]);

  const handleDataItemPress = React.useCallback((id: number) => {
    navigation.navigate('FlowsTableExpand', {flowId: id});
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleDataItemCheckedChange = React.useCallback(
    (bundleIdentifier: string, checked: boolean) => {
      ScarecrowNetwork.handleFlowRuleUpdate(bundleIdentifier, checked);
    },
    [],
  );

  React.useEffect(() => {
    ScarecrowNetwork.getFlows(null).then(setTableData);
    const listener = ScarecrowNetwork.handleFlowRequest(() =>
      ScarecrowNetwork.getFlows(null).then(setTableData),
    );

    return () => listener.remove();
  }, []);

  return (
    <Window title="Endpoints">
      <ScrollView>
        <SearchBar />

        <FlowsTable
          data={tableData}
          handleDataItemPress={handleDataItemPress}
          handleDataItemCheckedChange={handleDataItemCheckedChange}
        />
      </ScrollView>
    </Window>
  );
}

export default FlowsTableScreen;
