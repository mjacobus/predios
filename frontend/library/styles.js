import { css } from "glamor";

export const colors = {
  white: "white",
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
  jwPurple: "#a799b9",
  jwDarkPurple: "#3b3546",
  jwMiddlePurple: "#544a63",
  jwSoftPurple: "#746985",
  jwBrightPurple: "#63378d",
  fontRegular: "#555555"
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
  margin: "30px 15px"
});

const button = css({
  ":disabled": css({
    opacity: 0.4
  }),
  ":hover": css({
    opacity: 0.9,
    textDecoration: "none"
  }),
  background: colors.jwBrightPurple,
  border: "none",
  color: "white",
  padding: "0px 12px",
  fontSize: "14px",
  textAlign: "center",
  verticalAlign: "middle",
  lineHeight: "32px",
  height: "32px",
  cursor: "pointer",
  whiteSpace: "nowrap",
  float: "left"
});

const input = css({
  backround: "white",
  border: "1px solid #ddd",
  height: "32px",
  lineHeight: "32px",
  margin: "none",
  outline: "none",
  padding: "0 4px",
  width: "100%",
  ":disabled": {
    background: "#eee"
  }
});

const select = css(input, {
  " option": {
    bagckground: "gold"
  }
});

export const styles = {
  input,
  select,
  formContainer,
  button
};

const buttonStyles = {
  purple: {
    background: colors.jwLightPurple,
    color: colors.white,
    ":hover": {
      color: colors.white
    }
  },
  blue: {
    background: colors.jwBlue,
    color: colors.white,
    ":hover": {
      color: colors.white
    }
  },
  green: {
    background: colors.green,
    color: colors.white,
    color: colors.white,
    ":hover": {
      color: colors.white
    }
  },
  red: {
    background: colors.red,
    color: colors.white
  }
};

export const buttonStyler = (style, otherClass) => {
  return css(button, buttonStyles[style], otherClass);
};
