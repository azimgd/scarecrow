import React from 'react';
import {ScrollView} from 'react-native';
import {useRoute, RouteProp} from '@react-navigation/native';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import NetworkFlowsItemTable from './NetworkFlowsItemTable';
import {ListItem, Text, View} from 'tamagui';

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
    (event: ScarecrowNetwork.handleDataFromFlowEventPayload[]) => {
      setTableData(event);
    },
    [],
  );

  React.useEffect(() => {
    ScarecrowNetwork.getFlowsByBundleIdentifier(
      route.params.bundleIdentifier,
    ).then(handleDataFromFlowEvent);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <View>
      <ListItem
        backgroundColor="$colorTransparent"
        borderBottomColor="$borderColor"
        borderBottomWidth="$0.25">
        <Text color="#cccccc">View by</Text>
      </ListItem>

      <View borderLeftColor="$borderColor" borderLeftWidth="$0.5">
        <ScrollView>
          <NetworkFlowsItemTable data={tableData} />
        </ScrollView>
      </View>
    </View>
  );
}

export default NetworkFlowsItem;
