import {
  existsSync,
  mkdirSync,
  readdirSync,
  rmdirSync,
  statSync,
  unlinkSync,
} from "node:fs"
import {join} from "node:path"

export function ensureFolder(path: string) {
  if (existsSync(path)) {
    if (statSync(path).isDirectory()) return
    throw new Error(`existing file with the same path: ${path}`)
  }
  mkdirSync(path, {recursive: true})
}

/** It will also ensure that the folder exists. */
export function emptyFolder(path: string) {
  if (!existsSync(path)) return
  if (!statSync(path).isDirectory()) return
  for (const entry of readdirSync(path)) {
    const currentPath = join(path, entry)
    if (statSync(currentPath).isDirectory()) {
      emptyFolder(currentPath)
      rmdirSync(currentPath)
    } else {
      unlinkSync(currentPath)
    }
  }
}
