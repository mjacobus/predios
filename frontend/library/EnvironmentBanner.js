import React from "react";
import { css } from "glamor";
import { colors } from "./styles";

const testEnv = !!window.location.href.match(/localhost|staging/);

const className = css({
  background: colors.jwButtonOrange,
  color: colors.white,
  padding: "15px",
  marginTop: "50px"
});

export default function EnvironmentBanner() {
  if (!testEnv) {
    return <></>;
  }

  return (
    <p className={className}>Este é um sistema de teste. Use-o a vontande.</p>
  );
}
