import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import userService from 'services/User'
import { compose } from 'recompose'
import { withRouter } from 'react-router-dom'

class Header extends Component {

  logout () {
    userService.logout()
    this.props.history.push('/')
  }

  render () {
    const button = (
      <button
        className='nav-item logout btn btn-outline-light'
        onClick={this.logout.bind(this)}
      >
        <i className='fa fa-sign-out' /> Log Out
      </button>)

    const usersToFollow = <Link className='nav-item nav-link mr-3' to='/findUsers'>Follow users</Link>

    return (
      <nav className='navbar navbar-expand navbar-dark bg-primary fixed-top'>
        <Link to='/' className='navbar-brand'>
          <img className='img-fluid mr-1' width='30' height='30' src='/codurance-logo.png' alt='codurance logo' />
          <span className='align-middle'>OpenChat</span>
        </Link>

        <div className='navbar-nav ml-auto'>
          {userService.user ? usersToFollow : null}
          {userService.user ? button : null}
        </div>
      </nav>
    )
  }
}

export default compose(
  withRouter,
)(Header)
