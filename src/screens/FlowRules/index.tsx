import React from 'react';
import {ScrollView} from 'react-native';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import FlowRulesTable from './FlowRulesTable';
import Window from '../../components/Window';

function FlowRules(): JSX.Element {
  const [tableData, setTableData] = React.useState<
    ScarecrowNetwork.handleDataFromFlowEventPayload[]
  >([]);

  const handleDataItemPress = React.useCallback(() => {}, []);

  const handleDataItemCheckedChange = React.useCallback(
    (bundleIdentifier: string, checked: boolean) => {
      ScarecrowNetwork.updateFlowRule(bundleIdentifier, checked);
    },
    [],
  );

  React.useEffect(() => {
    ScarecrowNetwork.getRules().then(setTableData);
  }, []);

  return (
    <Window title="All Rules">
      <ScrollView>
        <FlowRulesTable
          data={tableData}
          handleDataItemPress={handleDataItemPress}
          handleDataItemCheckedChange={handleDataItemCheckedChange}
        />
      </ScrollView>
    </Window>
  );
}

export default FlowRules;
