import {NativeEventEmitter, NativeModules} from 'react-native';

export type FlowModel = {
  id: number;
  direction: string;
  remoteEndpoint: string;
  remoteUrl: string;
  createdAt: number;

  process: ProcessModel;
  distinctRemoteEndpoints: FlowModel[];
};

export type ProcessModel = {
  id: number;
  bundle: string;
  path: string;
  name: string;
  icon: string;

  sumFlowSize: number;
  countFlows: number;
  flows: FlowModel[];
};

export type RuleModel = {
  id: number;
  allowed: boolean;
  createdAt: number;

  process: ProcessModel;
};

const {ScarecrowNetwork} = NativeModules;
const eventEmitter = new NativeEventEmitter(ScarecrowNetwork);

export const getProcesses = ScarecrowNetwork.getProcesses;
export const getProcess = ScarecrowNetwork.getProcess;
export const countProcesses = ScarecrowNetwork.countProcesses;

export const getFlows = ScarecrowNetwork.getFlows;
export const getFlow = ScarecrowNetwork.getFlow;
export const countFlows = ScarecrowNetwork.countFlows;

export const getRules = ScarecrowNetwork.getRules;
export const getRule = ScarecrowNetwork.getRule;
export const countRules = ScarecrowNetwork.countRules;

export const handleFlowRuleUpdate = ScarecrowNetwork.handleFlowRuleUpdate;

export const handleFlowRequest = (listener: (event: any) => void) =>
  eventEmitter.addListener('handleFlowRequest', listener);
