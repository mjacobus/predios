import { connect } from "react-redux";
import TopMenu from "./library/TopMenu";
import { fetchCurrentuser } from "../processes/userProcesses";

function mapStateToProps(state) {
  return {
    currentUser: state.currentUser,
    app_version_url: state.config.version_url,
  };
}

function mapDispatchToProps(dispatch) {
  return {};
}

export const TopMenuContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(TopMenu);
export default TopMenuContainer;
