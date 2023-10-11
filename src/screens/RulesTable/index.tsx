import React from 'react';
import {ScrollView} from 'react-native';
import * as ScarecrowNetwork from '../../ScarecrowNetwork';
import RulesTable from './RulesTable';
import Window from '../../components/Window';

function RulesTableScreen(): JSX.Element {
  const [tableData, setTableData] = React.useState<
    ScarecrowNetwork.RuleModel[]
  >([]);

  const handleDataItemPress = React.useCallback(() => {}, []);

  const handleDataItemCheckedChange = React.useCallback(
    (bundleIdentifier: string, checked: boolean) => {
      ScarecrowNetwork.handleFlowRuleUpdate(bundleIdentifier, checked);
    },
    [],
  );

  React.useEffect(() => {
    ScarecrowNetwork.getRules().then(setTableData);
  }, []);

  return (
    <Window title="Rules">
      <ScrollView>
        <RulesTable
          data={tableData}
          handleDataItemPress={handleDataItemPress}
          handleDataItemCheckedChange={handleDataItemCheckedChange}
        />
      </ScrollView>
    </Window>
  );
}

export default RulesTableScreen;
