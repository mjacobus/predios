const consolePresent = () => {
  return (
    window && window.console && window.console.clear && window.__DATA__.debug
  );
};

const getConsole = () => window.console;

export function log() {
  if (consolePresent()) {
    return getConsole().log.apply(null, arguments);
  }
}

export function debug() {
  if (consolePresent()) {
    return getConsole().log.apply(null, arguments);
  }
}
