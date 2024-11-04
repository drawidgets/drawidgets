import {readFileSync, writeFileSync} from "fs"
import {join} from "path"
import {ensureFolder} from "./src/utils.ts"
import type {DebugLaunchConfigurations, DebugLaunchTask} from "./src/vscode.ts"

const from = "."
const dist = "dist"

/**
 * Generate a VSCode launch.json file at the specified {@link dist} folder.
 * It will generate inside the `<dist>/.vscode/launch.json` path,
 * and override the potential previous existing file.
 *
 * Attention that all those options are related to the {@link dist} path.
 */
export function generateVSCodeLaunch(
  dist: string,
  options?: {
    /**
     * Relative path on current workspace folder:
     * location of the folder with the extension package.json manifest at root.
     */
    extensionRoot?: string
    launchFolder?: string
  },
) {
  const launchExtension: DebugLaunchTask = {
    name: "VSCode theme extension",
    type: "extensionHost",
    request: "launch",
    args: (function () {
      const workspacePath = "${workspaceFolder}"
      const path = `${workspacePath}/${options?.extensionRoot ?? ""}`
      const handler = [`--extensionDevelopmentPath=${path}`]
      if (options?.launchFolder) {
        handler.push(`--folder-uri=${workspacePath}/${options.launchFolder}`)
      }
      return handler
    })(),
  }
  const allContents: DebugLaunchConfigurations = {
    configurations: [launchExtension],
  }
  const vscodeFolder = join(dist, ".vscode")
  ensureFolder(vscodeFolder)
  writeFileSync(join(vscodeFolder, "launch.json"), JSON.stringify(allContents))
}

export function generateVSCodeIgnore(dist: string) {
  const content = "# Placeholder.\n"
  writeFileSync(join(dist, ".vscodeignore"), content)
}

export function compileNodeManifest(from: string, dist: string) {
  const manifestFileName = "package.json"
  const content = readFileSync(join(from, manifestFileName)).toString()
  const manifest = JSON.parse(content)

  manifest["type"] = undefined // VSCode extension currently use CJS as default.
  manifest["scripts"] = undefined
  manifest["devDependencies"] = undefined
  if (manifest["engines"]) manifest["engines"]["node"] = undefined

  writeFileSync(join(dist, manifestFileName), JSON.stringify(manifest))
}

export function updateCompile(from: string, dist: string) {
  compileNodeManifest(from, dist)
  generateVSCodeIgnore(dist)
  generateVSCodeLaunch(dist, {extensionRoot: ".", launchFolder: "../.."})
}

function main() {
  ensureFolder(dist)
  updateCompile(from, dist)
}
main()
