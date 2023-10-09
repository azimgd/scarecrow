import {NativeEventEmitter, NativeModules} from 'react-native';

export type handleDataFromFlowEventPayload = {
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

export const getGrouppedFlowsByBundleIdentifier =
  ScarecrowNetwork.getGrouppedFlowsByBundleIdentifier;
export const countGrouppedFlowsByBundleIdentifier =
  ScarecrowNetwork.countGrouppedFlowsByBundleIdentifier;
export const getGrouppedFlowsByRemoteEndpoint =
  ScarecrowNetwork.getGrouppedFlowsByRemoteEndpoint;
export const countGrouppedFlowsByRemoteEndpoint =
  ScarecrowNetwork.countGrouppedFlowsByRemoteEndpoint;
export const getFlowsByBundleIdentifier =
  ScarecrowNetwork.getFlowsByBundleIdentifier;
export const updateFlowRule = ScarecrowNetwork.updateFlowRule;
export const getRules = ScarecrowNetwork.getRules;

export const handleDataFromFlowEvent = (
  listener: (event: handleDataFromFlowEventPayload) => void,
) => eventEmitter.addListener('handleDataFromFlowEvent', listener);
