import { connect } from "react-redux";
import TopMenu from "./library/TopMenu";
import { fetchCurrentuser } from "../processes/userProcesses";

function mapStateToProps(state) {
  return {
    currentUser: state.currentUser
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
