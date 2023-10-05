import React from 'react';
import {ScrollView} from 'react-native';
import {useNavigation} from '@react-navigation/native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowsPerHostnameTable from './FlowsPerHostnameTable';
import Window from '../../components/Window';
import SearchBar from '../../components/Searchbar';

type FlowsPerHostnameScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'FlowsPerHostname'
>;

function FlowsPerHostname(): JSX.Element {
  const navigation = useNavigation<FlowsPerHostnameScreenNavigationProp>();

  const [tableData, setTableData] = React.useState<
    ScarecrowNetwork.handleDataFromFlowEventPayload[]
  >([]);

  const handleDataItemPress = React.useCallback((bundleIdentifier: string) => {
    navigation.navigate('FlowsPerHostnameExpand', {bundleIdentifier});
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleDataItemCheckedChange = React.useCallback(
    (bundleIdentifier: string, checked: boolean) => {
      ScarecrowNetwork.updateFlowRule(bundleIdentifier, checked);
    },
    [],
  );

  React.useEffect(() => {
    ScarecrowNetwork.getGrouppedFlowsByRemoteEndpoint().then(setTableData);
    const listener = ScarecrowNetwork.handleDataFromFlowEvent(() =>
      ScarecrowNetwork.getGrouppedFlowsByRemoteEndpoint().then(setTableData),
    );

    return () => listener.remove();
  }, []);

  return (
    <Window title="Endpoints">
      <ScrollView>
        <SearchBar />

        <FlowsPerHostnameTable
          data={tableData}
          handleDataItemPress={handleDataItemPress}
          handleDataItemCheckedChange={handleDataItemCheckedChange}
        />
      </ScrollView>
    </Window>
  );
}

export default FlowsPerHostname;
