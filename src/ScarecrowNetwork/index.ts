import {NativeEventEmitter, NativeModules} from 'react-native';

export type handleDataFromFlowEventPayload = {
  remoteEndpoint: string;
  remoteUrl: string;
  direction: string;
  localizedName: string;
  bundleIdentifier: string;
  rule: {
    allowed: boolean;
  };
};

const {ScarecrowNetwork} = NativeModules;
const eventEmitter = new NativeEventEmitter(ScarecrowNetwork);

export const getGrouppedFlows = ScarecrowNetwork.getGrouppedFlows;
export const getFlowsByBundleIdentifier =
  ScarecrowNetwork.getFlowsByBundleIdentifier;
export const toggleFlowRule = ScarecrowNetwork.toggleFlowRule;

export const handleDataFromFlowEvent = (
  listener: (event: {string: handleDataFromFlowEventPayload}) => void,
) => eventEmitter.addListener('handleDataFromFlowEvent', listener);
