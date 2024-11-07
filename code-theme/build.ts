import {createVSIX} from "@vscode/vsce"
import {copyFileSync} from "fs"
import {join} from "path"
import {dist, from, updateCompile} from "./build.dev.ts"
import {emptyFolder} from "./src/utils.ts"

/** The output extension will be at the same folder of the {@link from} path. */
function build(from: string, dist: string) {
  emptyFolder(dist)
  updateCompile(from, dist)
  for (const file of ["README.md", "LICENSE.txt"]) {
    copyFileSync(join(from, file), join(dist, file))
  }
  createVSIX({cwd: dist, packagePath: from})
}

function main() {
  build(from, dist)
}
main()
