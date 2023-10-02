import React from 'react';
import {ScrollView} from 'react-native';
import {useNavigation} from '@react-navigation/native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import NetworkFlowsTable from './NetworkFlowsTable';
import {ListItem, Text, View} from 'tamagui';

type NetworkFlowsScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'NetworkFlows'
>;

function NetworkFlows(): JSX.Element {
  const navigation = useNavigation<NetworkFlowsScreenNavigationProp>();

  const [tableData, setTableData] = React.useState<
    ScarecrowNetwork.handleDataFromFlowEventPayload[]
  >([]);

  const handleDataFromFlowEvent = React.useCallback(
    (event: ScarecrowNetwork.handleDataFromFlowEventPayload) => {
      if (!event.bundleIdentifier) {
        return;
      }

      setTableData(state => {
        const itemIndex = state.findIndex(
          item => item.bundleIdentifier === event.bundleIdentifier,
        );

        if (itemIndex === -1) {
          return state.concat(event);
        }

        return state;
      });
    },
    [],
  );

  const handleDataItemPress = React.useCallback((bundleIdentifier: string) => {
    navigation.navigate('NetworkFlowsItem', {bundleIdentifier});
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleDataItemCheckedChange = React.useCallback(
    (bundleIdentifier: string, checked: boolean) => {
      checked;
      ScarecrowNetwork.toggleFlowRule(bundleIdentifier);
    },
    [],
  );

  React.useEffect(() => {
    ScarecrowNetwork.getGrouppedFlows().then(
      (flows: ScarecrowNetwork.handleDataFromFlowEventPayload[]) =>
        setTableData(flows),
    );

    // const subscription = ScarecrowNetwork.handleDataFromFlowEvent(
    //   handleDataFromFlowEvent,
    // );

    // return () => subscription.remove();
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
          <NetworkFlowsTable
            data={tableData}
            handleDataItemPress={handleDataItemPress}
            handleDataItemCheckedChange={handleDataItemCheckedChange}
          />
        </ScrollView>
      </View>
    </View>
  );
}

export default NetworkFlows;
