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
export const countGrouppedFlowsByBundleIdentifier =
  ScarecrowNetwork.countGrouppedFlowsByBundleIdentifier;
export const getGrouppedFlowsByRemoteEndpoint =
  ScarecrowNetwork.getGrouppedFlowsByRemoteEndpoint;
export const countGrouppedFlowsByRemoteEndpoint =
  ScarecrowNetwork.countGrouppedFlowsByRemoteEndpoint;
export const getFlowsByBundleIdentifier =
  ScarecrowNetwork.getFlowsByBundleIdentifier;
export const updateFlowRule = ScarecrowNetwork.updateFlowRule;

export const handleDataFromFlowEvent = (
  listener: (event: handleDataFromFlowEventPayload) => void,
) => eventEmitter.addListener('handleDataFromFlowEvent', listener);
