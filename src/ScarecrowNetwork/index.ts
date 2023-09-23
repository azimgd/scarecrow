import {NativeEventEmitter, NativeModules} from 'react-native';

export type handleDataFromFlowEventPayload = {
  remoteEndpoint: string;
  remoteUrl: string;
  direction: string;
  localizedName: string;
  bundleIdentifier: string;
};

const {ScarecrowNetwork} = NativeModules;
const eventEmitter = new NativeEventEmitter(ScarecrowNetwork);

export const getGrouppedFlows = ScarecrowNetwork.getGrouppedFlows;
export const getFlowsByBundleIdentifier =
  ScarecrowNetwork.getFlowsByBundleIdentifier;

export const handleDataFromFlowEvent = (
  listener: (event: {string: handleDataFromFlowEventPayload}) => void,
) => eventEmitter.addListener('handleDataFromFlowEvent', listener);
