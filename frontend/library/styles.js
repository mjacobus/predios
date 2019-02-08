import { css } from "glamor";

export const colors = {
  red: "#ce2b2b",
  green: "#006100",
  lightGray: "#ddd",
  softBlue: "#b1c6da",
  lightBlue: "#b1c6da",
  jwBlue: "#4a6da7",
  jwFont: "#555555",
  jwMenu: "#373333",
  jwOrange: "#eab48a",
  jwLogo: "#5478b0",
  jwOtherOrange: "#e7ab7f",
  jwButtonOrange: "#eb6a00",
  jwGreen: "#92ce9d",
  jwPurple: "#a799b9"
};

const biggestFontSize = 28;

export const fontSizes = {
  h1: `${biggestFontSize}px`,
  h2: `${biggestFontSize - 2}px`,
  h3: `${biggestFontSize - 4}px`,
  h4: `${biggestFontSize - 6}px`,
  h5: `${biggestFontSize - 8}px`,
  h6: `${biggestFontSize - 9}px`
};

const formContainer = css({
  height: "95px",
  padding: "30px 15px",
  border: "1px solid #ddd",
  margin: "30px 15px",
  background: colors.lightGray
});

const button = css({
  ":disabled": css({
    opacity: 0.4
  }),
  background: colors.jwBlue,
  border: "none",
  color: "white",
  padding: "0px 12px",
  fontSize: "14px",
  textAlign: "center",
  verticalAlign: "middle",
  lineHeight: "32px",
  height: "32px",
  cursor: "pointer",
  whiteSpace: "nowrap"
});

export const styles = {
  formContainer,
  button
};