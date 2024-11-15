import {Color} from "./color.ts"

export type FontStyle =
  | ""
  | "italic"
  | "bold"
  | "underline"
  | "strikethrough"
  | "italic bold"
  | "italic underline"
  | "italic strikethrough"
  | "italic bold underline"
  | "italic bold strikethrough"
  | "italic underline strikethrough"
  | "italic bold underline strikethrough"
  | "bold underline"
  | "bold strikethrough"
  | "bold underline strikethrough"
  | "underline strikethrough"

export type SemanticTokens =
  | "class.constructor"
  | "enum"
  | "enumMember"
  | "functions"
  | "namespace"
  | "parameter"
  | "parameter.label"
  | "property"
  | "property.annotation"
  | "property.static"
  | "variables"
  | "types"

export type ThemeTokens =
  | "activityBar.activeBorder"
  | "activityBar.background"
  | "activityBar.border"
  | "activityBar.foreground"
  | "activityBar.inactiveForeground"
  | "activityBarBadge.background"
  | "activityBarBadge.foreground"
  | "badge.background"
  | "badge.foreground"

export type TokenColorSettings = {
  foreground?: Color
  fontStyle?: FontStyle
}

export type TokenColor = {
  scope: string | string[]
  settings: TokenColorSettings
}

export type SemanticTokenColors = {
  [key in SemanticTokens]?: Color | TokenColorSettings
}

export type ThemeColors = {
  [key in ThemeTokens]?: Color
}

export type ColorTheme = {
  colors?: ThemeColors
  semanticHighlighting?: boolean
  semanticTokenColors?: SemanticTokenColors
  tokenColors?: TokenColor[]
}
