import {connect} from 'react-redux';
import TopMenu from "./library/TopMenu";

function mapStateToProps(state) {
  return {
    currentUser: {
      name: 'The name of the user',
      email: 'user@email.com',
      master: true,
      enabled: true,
    }
  };
}

function mapDispatchToProps(dispatch) {
  return {
    // fetchTerritory: (slug) => {
    //   dispatch(fetchTerritory(slug));
    // },
    //
    // submitValues: (slug, values) => {
    //   dispatch(updateTerritory(slug, values));
    // },
    //
    // resetPersisted: () => {
    //   dispatch(resetPersisted());
    // }
  };
}

export const TopMenuContainer = connect(mapStateToProps, mapDispatchToProps)(TopMenu);
export default TopMenuContainer;
