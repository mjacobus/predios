import React from "React";
import { css } from "glamor";
import { colors } from "./styles";
import Label from "./Label";

const onStyle = css({
  background: colors.green,
  float: "right"
});

const offStyle = css({
  background: colors.gray,
  float: "left"
});

const switchFlagStyle = css({
  height: "20px",
  width: "20px",
  borderRadius: "12px"
});

const switchContainerStyle = css({
  width: "35px",
  height: "22px",
  float: "left",
  border: "1px solid #ddd",
  marginRight: "10px",
  borderRadius: "12px"
});

const labelStyle = css({
  cursor: "pointer"
});

const defaultToggler = (event, entity) => {
  console.log(`Default toggler for ${entity}`);
};

const SwitchButton = ({ on }) => {
  const className = css(on ? onStyle : offStyle, switchFlagStyle);

  return (
    <span className={switchContainerStyle}>
      <span className={className} />
    </span>
  );
};

export default function Toggler({
  entity = {},
  label,
  locked,
  toggler = defaultToggler,
  ...otherProps
}) {
  return (
    <Label className={labelStyle} onClick={e => toggler(entity)}>
      <SwitchButton {...otherProps} />
      <span>{label}</span>
    </Label>
  );
}
