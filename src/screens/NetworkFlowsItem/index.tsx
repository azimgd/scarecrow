import React from 'react';
import {ScrollView} from 'react-native';
import {useNavigation, useRoute, RouteProp} from '@react-navigation/native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../../navigation/index';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import History from '../../components/History';

type NetworkFlowsItemScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'NetworkFlowsItem'
>;

type NetworkFlowsItemScreenRouteProp = RouteProp<
  RootStackParamList,
  'NetworkFlowsItem'
>;

function NetworkFlowsItem(): JSX.Element {
  const navigation = useNavigation<NetworkFlowsItemScreenNavigationProp>();
  const route = useRoute<NetworkFlowsItemScreenRouteProp>();

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
    bundleIdentifier;
    navigation.navigate('NetworkFlows', undefined);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  React.useEffect(() => {
    ScarecrowNetwork.getFlowsByBundleIdentifier(
      route.params.bundleIdentifier,
    ).then(handleDataFromFlowEvent);

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

export default NetworkFlowsItem;
