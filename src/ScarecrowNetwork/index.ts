import {NativeEventEmitter, NativeModules} from 'react-native';

export type handleFlowRequestPayload = {
  remoteEndpoint: string;
  remoteUrl: string;
  direction: string;
  name: string;
  bundleIdentifier: string;
  rule: {
    allowed: boolean;
  };
  size: number;

  icon: string;
  totalCount: number;
};

const {ScarecrowNetwork} = NativeModules;
const eventEmitter = new NativeEventEmitter(ScarecrowNetwork);

export const getProcesses = ScarecrowNetwork.getProcesses;
export const countProcesses = ScarecrowNetwork.countProcesses;
export const getFlows = ScarecrowNetwork.getFlows;
export const countFlows = ScarecrowNetwork.countFlows;
export const handleFlowRuleUpdate = ScarecrowNetwork.handleFlowRuleUpdate;
export const getRules = ScarecrowNetwork.getRules;

export const handleFlowRequest = (
  listener: (event: handleFlowRequestPayload) => void,
) => eventEmitter.addListener('handleFlowRequest', listener);
