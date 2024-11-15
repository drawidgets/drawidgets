export type DebugLaunchTask = {
  name: string
  type: "extensionHost" | "node" | "pwa-node" | "pwa-extensionHost"
  request: "launch" | "attach"
  args?: string[]
}

export type DebugLaunchConfigurations = {
  version?: string
  configurations: DebugLaunchTask[]
}
