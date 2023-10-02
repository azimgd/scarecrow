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
  size: number;
  date: string;

  totalSize: number;
  totalCount: number;
};

const {ScarecrowNetwork} = NativeModules;
const eventEmitter = new NativeEventEmitter(ScarecrowNetwork);

export const getGrouppedFlowsByBundleIdentifier =
  ScarecrowNetwork.getGrouppedFlowsByBundleIdentifier;
export const getGrouppedFlowsByRemoteEndpoint =
  ScarecrowNetwork.getGrouppedFlowsByRemoteEndpoint;
export const getFlowsByBundleIdentifier =
  ScarecrowNetwork.getFlowsByBundleIdentifier;
export const toggleFlowRule = ScarecrowNetwork.toggleFlowRule;

export const handleDataFromFlowEvent = (
  listener: (event: handleDataFromFlowEventPayload) => void,
) => eventEmitter.addListener('handleDataFromFlowEvent', listener);
