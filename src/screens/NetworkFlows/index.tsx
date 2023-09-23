import React from 'react';
import {ScrollView} from 'react-native';
import {useNavigation} from '@react-navigation/native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import History from '../../components/History';

type NetworkFlowsScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'NetworkFlows'
>;

function NetworkFlows(): JSX.Element {
  const navigation = useNavigation<NetworkFlowsScreenNavigationProp>();

  const [history, setHistory] = React.useState<
    ScarecrowNetwork.handleDataFromFlowEventPayload[]
  >([]);

  const handleDataFromFlowEvent = React.useCallback(
    (event: {string: ScarecrowNetwork.handleDataFromFlowEventPayload}) => {
      setHistory(Object.values(event));
    },
    [],
  );

  const handleItemSelect = React.useCallback((bundleIdentifier: string) => {
    navigation.navigate('NetworkFlowsItem', {bundleIdentifier});
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  React.useEffect(() => {
    ScarecrowNetwork.getGrouppedFlows().then(handleDataFromFlowEvent);

    const subscription = ScarecrowNetwork.handleDataFromFlowEvent(
      handleDataFromFlowEvent,
    );
    return () => subscription.remove();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <ScrollView>
      <History history={history} handleItemSelect={handleItemSelect} />
    </ScrollView>
  );
}

export default NetworkFlows;
