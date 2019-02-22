import React from "React";
import { css } from "glamor";
import { colors } from "./styles";

const onStyle = css({
  color: colors.white,
  background: colors.green
});

const offStyle = css({
  color: colors.white,
  background: colors.red
});

export default function Toggler({ user, on, options }) {
  const className = css(on ? onStyle : offStyle);

  return <div className={className}>sup</div>;
}
