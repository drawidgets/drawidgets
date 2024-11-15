export type Color = string
export function color(
  alpha: number,
  red: number,
  green: number,
  blue: number,
): Color {
  // Validate parameters.
  for (const value of [alpha, red, green, blue]) {
    function formatColor() {
      const values = [
        `alpha: ${alpha}`,
        `red: ${red}`,
        `green: ${green}`,
        `blue: ${blue}`,
      ].join(", ")
      return `color(${values})`
    }
    if (Number.isInteger(value) === false) {
      throw new Error(`color value must be integer: ${formatColor()}`)
    } else if (value < 0 || value > 255) {
      throw new Error(`color value must be between 0 and 255: ${formatColor()}`)
    }
  }
  return (
    "#" +
    alpha.toString(16) +
    red.toString(16) +
    green.toString(16) +
    blue.toString(16)
  )
}
